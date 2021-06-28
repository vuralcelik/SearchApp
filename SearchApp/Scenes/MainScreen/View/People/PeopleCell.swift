//
//  PeopleCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class PeopleCell: BaseCollectionViewCell {
    //MARK: - Views
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [peopleProfileImageView,
                                                  peopleNameLabel])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 4
        return view
    }()
    
    lazy var peopleProfileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .red
        view.clipsToBounds = true
        return view
    }()
    
    lazy var peopleNameLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        view.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
        return view
    }()
    
    //MARK: - Computed Properties
    var peopleSearchModel: PeopleResponseModel? {
        didSet {
            guard let validatedPeopleSearchModel = peopleSearchModel else { return }
            peopleNameLabel.text = validatedPeopleSearchModel.name
            ImageManager.setImage(imageView: peopleProfileImageView, urlString: validatedPeopleSearchModel.profilePath)
        }
    }
    
    //MARK: - Life Cycle
    override func commonInit() {
        super.commonInit()
        
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(containerStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
    }
}