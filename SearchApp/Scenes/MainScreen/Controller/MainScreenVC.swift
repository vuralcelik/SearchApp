//
//  MainScreenVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainScreenVC: BaseVC,
                    MoviesCollectionViewCellDelegate,
                    PeopleTableViewCellDelegate {
    //MARK: - Views
    lazy var customSearchBar: CustomSearchBarView = {
        let view = CustomSearchBarView()
        view.setupSearchBar(textFieldPlaceholderText: L10n.searchBarPlaceholderText,
                            textFieldKeyboardType: .default,
                            textFieldAutocorrectionType: .no,
                            textFieldTextContentType: .none,
                            textFieldAlignment: .left,
                            buttonTitle: L10n.searchBarCancelTitle)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.bounces = true
        view.rx.setDelegate(mainScreenVM).disposed(by: disposeBag)
        view.rx.setDataSource(mainScreenVM).disposed(by: disposeBag)
        view.registerCells(types: [MoviesTableViewCell.self,
                                   PeopleTableViewCell.self,
                                   OnlyMovieCell.self,
                                   EmptyStateCell.self])
        return view
    }()
    
    //MARK: - Properties
    let mainScreenVM = MainScreenVM()
    
    //MARK: - Events
    override func bindEvents() {
        customSearchBar
            .customTextFieldView
            .textField
            .rx
            .controlEvent([.editingChanged])
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let textField = self.customSearchBar.customTextFieldView.textField
                self.mainScreenVM.searchText = textField.text
                if self.mainScreenVM.shouldCallSearch(by: textField) {
                    self.getSearchMoviesAndPeoples(searchText: self.mainScreenVM.searchText)
                }
            }).disposed(by: disposeBag)
        
        customSearchBar
            .customButton
            .rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.getPopularMovies()
                self.customSearchBar.customTextFieldView.textField.text = nil
                self.view.endEditing(true)
            }).disposed(by: disposeBag)
        
        tableView
            .rx
            .itemSelected
            .subscribe { [weak self] indexPath in
                guard let self = self,
                      let validatedRow = indexPath.element?.row else { return }
                switch self.mainScreenVM.searchType {
                case .onlyPopularMovies:
                    self.navigateToMovieDetail(movie: self.mainScreenVM.getMovie(by: validatedRow))
                default:
                    break
                }
            }.disposed(by: disposeBag)
        
        mainScreenVM.scrollViewDidScrollPublishSubject
            .asObservable()
            .subscribe { [weak self] (scrollViewEvent) in
                guard let self = self else { return }
                if self.mainScreenVM.searchType == .onlyPopularMovies {
                    guard let scrollView = scrollViewEvent.element else { return }
                    let pulledOffset = (scrollView.contentOffset.y + scrollView.frame.size.height)
                    let contentHeight = scrollView.contentSize.height
                    if ((pulledOffset > contentHeight) && !self.mainScreenVM.isLoadingList) {
                        self.mainScreenVM.isLoadingList = true
                        self.getPopularMovies()
                    }
                }
            }.disposed(by: disposeBag)

    }
    
    func itemSelectedAtMoviesCollectionView(index: Int) {
        navigateToMovieDetail(movie: mainScreenVM.getMovie(by: index))
    }
    
    func itemSelectedInPeopleCollectionView(index: Int) {
        navigateToPeople(people: mainScreenVM.getPeople(by: index))
    }
    
    func scrollViewDidScrollInSearchMoviesCollection(_ scrollView: UIScrollView) {
        if mainScreenVM.searchType == .multiSearch {
            let pulledOffset = (scrollView.contentOffset.x + scrollView.frame.size.width)
            let contentHeight = scrollView.contentSize.width
            if ((pulledOffset > contentHeight) && !self.mainScreenVM.isLoadingList){
                self.mainScreenVM.isLoadingList = true
                self.getSearchOnlyMovies()
            }
        }
    }
    
    func scrollViewDidScrollInSearchPeoplesCollection(_ scrollView: UIScrollView) {
        if mainScreenVM.searchType == .multiSearch {
            let pulledOffset = (scrollView.contentOffset.x + scrollView.frame.size.width)
            let contentHeight = scrollView.contentSize.width
            if ((pulledOffset > contentHeight) && !self.mainScreenVM.isLoadingList){
                self.mainScreenVM.isLoadingList = true
                self.getSearchOnlyPeoples()
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        getPopularMovies()
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        view.addSubview(tableView)
        view.addSubview(customSearchBar)
        view.bringSubviewToFront(customSearchBar)
    }
    
    override func setupLayout() {
        super.setupLayout()
        customSearchBar.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(55)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        navigationItem.title = L10n.searchNavTitle
    }
    
    //MARK: - Helper Methods
    override func observeViewModel() {
        mainScreenVM.movieCollectionViewCellDelegate = self
        mainScreenVM.peopleTableViewCellDelegate = self
    }
    
    //MARK: - Service Calls
    private func getPopularMovies() {
        PopUpManager.showLoading(fromVC: self) { [weak self] (loadingVC) in
            guard let self = self else { return }
            self.mainScreenVM.getPopularMovies().subscribe
            { [weak self] (response: BasePaginationResponseModel<MovieResponseModel>) in
                guard let self = self else { return }
                let lastMovies = self.mainScreenVM.getPopularMoviesResponse.value
                self.mainScreenVM.getPopularMoviesResponse.accept(lastMovies + (response.results ?? []))
                self.mainScreenVM.searchType = .onlyPopularMovies
                self.tableView.reloadData()
                self.mainScreenVM.isLoadingList = false
                loadingVC.dismiss(animated: true)
            } onError: { [weak self] (error) in
                guard let self = self else { return }
                self.mainScreenVM.isLoadingList = false
                loadingVC.dismiss(animated: true) { [weak self] in
                    self?.showError(description: error.localizedDescription)
                }
            }.disposed(by: self.disposeBag)
        }
    }

    private func getSearchMoviesAndPeoples(searchText: String?) {
        guard let validatedSearchText = searchText else { return }
        mainScreenVM.clearPageNumbersForNewSearch()
        Observable.zip(mainScreenVM.getSearchMovies(searchText: validatedSearchText),
                       mainScreenVM.getSearchPeoples(searchText: validatedSearchText))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] (movies, peoples) in
                guard let self = self else { return }
                self.mainScreenVM.getSearchMoviesResponse.accept(movies.results ?? [])
                self.mainScreenVM.getSearchPeoplesResponse.accept(peoples.results ?? [])
                self.mainScreenVM.searchType = .multiSearch
                self.tableView.reloadData()
                self.mainScreenVM.isLoadingList = false
            }
            onError: { [weak self] (error) in
                guard let self = self else { return }
                self.mainScreenVM.isLoadingList = false
                self.showError(description: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    private func getSearchOnlyMovies() {
        mainScreenVM.searchMoviesCurrentPage += 1
        PopUpManager.showLoading(fromVC: self) { [weak self] (loadingVC) in
            guard let self = self else { return }
            guard let validatedSearchText = self.mainScreenVM.searchText else { return }
            self.mainScreenVM.getSearchMovies(searchText: validatedSearchText)
                .subscribe { [weak self] (response: BasePaginationResponseModel<MovieResponseModel>) in
                    guard let self = self else { return }
                    let lastMovies = self.mainScreenVM.getSearchMoviesResponse.value
                    self.mainScreenVM.getSearchMoviesResponse.accept(lastMovies + (response.results ?? []))
                    self.tableView.reloadData()
                    self.mainScreenVM.isLoadingList = false
                    loadingVC.dismiss(animated: true)
                } onError: { [weak self] (error) in
                    guard let self = self else { return }
                    self.mainScreenVM.isLoadingList = false
                    loadingVC.dismiss(animated: true) { [weak self] in
                        self?.showError(description: error.localizedDescription)
                    }
                }.disposed(by: self.disposeBag)
        }
    }
    
    private func getSearchOnlyPeoples() {
        mainScreenVM.searchPeoplesCurrentPage += 1
        PopUpManager.showLoading(fromVC: self) { [weak self] (loadingVC) in
            guard let self = self else { return }
            guard let validatedSearchText = self.mainScreenVM.searchText else { return }
            self.mainScreenVM.getSearchPeoples(searchText: validatedSearchText)
                .subscribe { [weak self] (response: BasePaginationResponseModel<PeopleResponseModel>) in
                    guard let self = self else { return }
                    let lastPeoples = self.mainScreenVM.getSearchPeoplesResponse.value
                    self.mainScreenVM.getSearchPeoplesResponse.accept(lastPeoples + (response.results ?? []))
                    self.tableView.reloadData()
                    loadingVC.dismiss(animated: true)
                } onError: { [weak self] (error) in
                    guard let self = self else { return }
                    loadingVC.dismiss(animated: true) { [weak self] in
                        self?.showError(description: error.localizedDescription)
                    }
                }.disposed(by: self.disposeBag)
        }
    }
    
    //MARK: - Navigations
    private func navigateToMovieDetail(movie: MovieResponseModel) {
        let vc = MovieDetailVC()
        vc.movieDetailVM.navigatedMovieBehaviorRelay.accept(movie)
        push(to: vc)
    }
    
    private func navigateToPeople(people: PeopleResponseModel) {
        let vc = PeopleDetailVC()
        vc.peopleDetailVM.navigatedPeopleResponse.accept(people)
        push(to: vc)
    }
}
