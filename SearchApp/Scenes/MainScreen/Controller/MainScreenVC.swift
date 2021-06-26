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
        view.registerCells(types: [MovieCell.self])
        return view
    }()
    
    //MARK: - Properties
    let mainScreenVM = MainScreenVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    
    //MARK: - Events
    override func bindEvents() {
        tableView
        .rx
        .itemSelected
        .subscribe(onNext: { [weak self] indexPath in
            self?.navigateToMovieDetail()
        }).disposed(by: disposeBag)
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
    private func bindTableView() {
        mainScreenVM.items
        .bind(to: tableView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { indexPath, title, cell in
            
        }
        .disposed(by: disposeBag)
    }
    
    //MARK: - Navigations
    private func navigateToMovieDetail() {
        push(to: UIViewController())
    }
}
