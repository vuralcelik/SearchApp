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

class MainScreenVC: BaseVC {
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
        view.registerCells(types: [MoviesTableViewCell.self])
        return view
    }()
    
    //MARK: - Properties
    let mainScreenVM = MainScreenVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovies()
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customSearchBar)
        customSearchBar.sizeToFit()
    }
    
    //MARK: - Helper Methods
    
    //MARK: - Service Calls
    private func getPopularMovies() {
        mainScreenVM.getPopularMovies().subscribe(
        onNext: { [weak self] (response: BasePaginationResponseModel<MovieResponseModel>) in
            guard let self = self else { return }
            self.mainScreenVM.getPopularPeoplesResponse.accept(response.results ?? [])
            self.tableView.reloadData()
        },
        onError: { (error) in
            ///TODO - Make error pop up
        }).disposed(by: disposeBag)
    }
    
    //MARK: - Navigations
    private func navigateToMovieDetail() {
        push(to: UIViewController())
    }
}
