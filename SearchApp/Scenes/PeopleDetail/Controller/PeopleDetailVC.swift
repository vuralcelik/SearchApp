//
//  PeopleDetailVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit
import RxSwift
import RxCocoa

class PeopleDetailVC: BaseVC {
    //MARK: - Views
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.bounces = true
        view.isScrollEnabled = true
        view.isHidden = true
        return view
    }()
    
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [coverPhotoImageView,
                                                  descriptionContainerView,
                                                  creditsContainerView])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    lazy var coverPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var descriptionContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var descriptionContainerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [peopleNameLabel,
                                                  peopleBiographyLabel])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 0
        return view
    }()
    
    lazy var peopleNameLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var peopleBiographyLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var creditsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var creditsContainerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [creditsTitleLabel,
                                                  collectionView])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    lazy var creditsTitleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 1
        view.text = L10n.peopleDetailCreditTitle
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: 210,
                                 height: 400)
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        view.bounces = true
        view.backgroundColor = .clear
        view.registerCells(types: [MovieCell.self])
        view.dataSource = peopleDetailVM
        return view
    }()
    
    //MARK: - Properties
    let peopleDetailVM = PeopleDetailVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        getPeopleDetailAndMovieCredits()
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        navigationItem.title = L10n.peopleDetailNavTitle
    }
    
    //MARK: - Events
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        view.addSubview(scrollView)
        descriptionContainerView.addSubview(descriptionContainerStackView)
        scrollView.addSubview(containerStackView)
        creditsContainerView.addSubview(creditsContainerStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView.snp.height).priority(1)
            make.width.equalTo(scrollView.snp.width)
        }
        
        descriptionContainerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        
        coverPhotoImageView.snp.makeConstraints { (make) in
            make.width.equalTo(175)
            make.height.equalTo(305)
        }
        
        creditsContainerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.height.equalTo(400)
        }
    }
    
    //MARK: - Helper Methods
    override func observeViewModel() {
        peopleDetailVM.peopleDetailResponse
            .asObservable()
            .subscribe { [weak self] (peopleDetailResponse) in
                guard let self = self else { return }
                self.peopleNameLabel.text = peopleDetailResponse.element?.name
                self.peopleBiographyLabel.text = peopleDetailResponse.element?.biography ?? "-"
                self.coverPhotoImageView.setImageWithCaching(urlString: peopleDetailResponse.element?.profilePath)
            }.disposed(by: disposeBag)
        
        peopleDetailVM.peopleDetailMovieCreditsResponse
            .asObservable()
            .subscribe { [weak self] (peopleDetailMovieCreditsResponse) in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.disposed(by: disposeBag)
    }
    
    //MARK: - Navigations
    
    //MARK: - Service Calls
    func getPeopleDetailAndMovieCredits() {
        Observable.zip(peopleDetailVM.getPeopleDetail(),
                       peopleDetailVM.getPeopleMovieCredits())
            .subscribe { [weak self] (peopleDetailResponse, peopleDetailMovieCreditsResponse) in
                guard let self = self else { return }
                self.peopleDetailVM.peopleDetailResponse.accept(peopleDetailResponse)
                self.peopleDetailVM.peopleDetailMovieCreditsResponse.accept(peopleDetailMovieCreditsResponse)
                self.scrollView.isHidden = false
            } onError: { [weak self] (error) in
                self?.showError(description: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
