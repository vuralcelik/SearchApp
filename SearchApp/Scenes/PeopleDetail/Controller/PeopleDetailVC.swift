//
//  PeopleDetailVC.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class PeopleDetailVC: BaseVC {
    //MARK: - Views
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.bounces = true
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [coverPhotoImageView,
                                                  descriptionContainerView])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    lazy var coverPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
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
                                                  peopleBiographyLabel,
                                                  peopleMovieCredits])
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
    
    lazy var peopleMovieCredits: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - Properties
    let peopleDetailVM = PeopleDetailVM()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
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
    }
    
    //MARK: - Helper Methods
    override func observeViewModel() {
        peopleDetailVM.navigatedPeopleResponse
            .asObservable()
            .subscribe { [weak self] people in
                guard let self = self else { return }
                self.peopleNameLabel.text = people.element??.name
                self.peopleBiographyLabel.text = people.element??.name
            }.disposed(by: disposeBag)

    }
    
    //MARK: - Navigations
    
    //MARK: - Service Calls
}
