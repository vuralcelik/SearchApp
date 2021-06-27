//
//  MovieDetailVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailVC: BaseVC {
    //MARK: - Views
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.rx.setDelegate(movieDetailVM).disposed(by: disposeBag)
        view.rx.setDataSource(movieDetailVM).disposed(by: disposeBag)
        view.registerCells(types: [CoverPhotoCell.self,
                                   MovieDetailInformationsCell.self,
                                   MovieDetailLinkCell.self])
        return view
    }()
    
    //MARK: - Properties
    let movieDetailVM = MovieDetailVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Events
    override func bindEvents() {
        tableView
            .rx
            .itemSelected
            .subscribe { [weak self] (indexPath) in
                guard let self = self,
                      let validatedSection = indexPath.element?.section,
                      let validatedRow = indexPath.element?.row else { return }
                switch self.movieDetailVM.getSectionType(section: validatedSection) {
                case .videos:
                    break
                default:
                    break
                }
            }.disposed(by: disposeBag)
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
        
    }
    
    //MARK: - Helper Methods
    
    //MARK: - Navigations
    
    //MARK: - Service Calls
}
