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
        view.rx.setDelegate(mainScreenVM).disposed(by: disposeBag)
        view.rx.setDataSource(mainScreenVM).disposed(by: disposeBag)
        view.registerCells(types: [MoviesTableViewCell.self,
                                   PeopleTableViewCell.self,
                                   OnlyMovieCell.self])
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
                if self.mainScreenVM.shouldCallSearch(by: textField) {
                    self.getSearchMoviesAndPeoples(searchText: textField.text)
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
    }
    
    func itemSelectedAtMoviesCollectionView(index: Int) {
        navigateToMovieDetail(movie: mainScreenVM.getMovie(by: index))
    }
    
    func itemSelectedInPeopleCollectionView(index: Int) {
        navigateToPeople(people: mainScreenVM.getPeople(by: index))
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
        mainScreenVM.getPopularMovies().subscribe(
        onNext: { [weak self] (response: BasePaginationResponseModel<MovieResponseModel>) in
            guard let self = self else { return }
            self.mainScreenVM.getPopularMoviesResponse.accept(response.results ?? [])
            self.mainScreenVM.searchType = .onlyPopularMovies
            self.tableView.reloadData()
        },
        onError: { (error) in
            ///TODO - Make error pop up
        }).disposed(by: disposeBag)
    }

    private func getSearchMoviesAndPeoples(searchText: String?) {
        guard let validatedSearchText = searchText else { return }
        Observable.zip(mainScreenVM.getSearchMovies(searchText: validatedSearchText),
                       mainScreenVM.getSearchPeoples(searchText: validatedSearchText))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { [weak self] (movies, peoples) in
                guard let self = self else { return }
                self.mainScreenVM.getSearchMoviesResponse.accept(movies.results ?? [])
                self.mainScreenVM.getSearchPeoplesResponse.accept(peoples.results ?? [])
                self.mainScreenVM.searchType = .multiSearch
                self.tableView.reloadData()
            }
            onError: { (error) in
                ///TODO - Make error pop up
            }.disposed(by: disposeBag)

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
