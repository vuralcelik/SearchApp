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
        view.rx.setDataSource(movieDetailVM).disposed(by: disposeBag)
        view.registerCells(types: [CoverPhotoCell.self,
                                   MovieDetailInformationsCell.self,
                                   MovieDetailLinkCell.self])
        view.isHidden = true
        return view
    }()
    
    //MARK: - Properties
    let movieDetailVM = MovieDetailVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieCredits()
    }
    
    //MARK: - Events
    override func bindEvents() {
        tableView
            .rx
            .itemSelected
            .subscribe { [weak self] (indexPath) in
                guard let self = self,
                      let validatedSection = indexPath.element?.section else { return }
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
    override func observeViewModel() {
        movieDetailVM.movieCreditsResponse
            .asObservable()
            .subscribe { [weak self] (movieCreditsResponseModel) in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Navigations
    
    //MARK: - Service Calls
    func getMovieCredits() {
        movieDetailVM.getMovieCredits()
            .subscribe { [weak self] (movieCreditsResponse) in
                guard let self = self else { return }
                self.movieDetailVM.movieCreditsResponse.accept(movieCreditsResponse)
                self.tableView.isHidden = false
            } onError: { [weak self] (error) in
                self?.showError(description: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
