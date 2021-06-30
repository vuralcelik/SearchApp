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
        view.spacing = 0
        return view
    }()
    
    lazy var peopleProfileImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var peopleNameLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .center
        view.numberOfLines = 1
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
            peopleProfileImageView.setImageWithCaching(urlString: validatedPeopleSearchModel.profilePath)
        }
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
        
        peopleProfileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
    }
}
