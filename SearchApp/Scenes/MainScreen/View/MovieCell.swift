//
//  MovieCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class MovieCell: BaseTableViewCell {
    //MARK: - Views
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [moviePosterImageView,
                                                  informationContainerStackView])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 4
        return view
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var informationContainerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieTitleLabel,
                                                  movieVoteLabel])
        view.backgroundColor = .clear
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 4
        return view
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.text = "äsdklsalkdjasl"
        view.textAlignment = .left
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var movieVoteLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.text = "äsdklsalkdjasl"
        view.textAlignment = .right
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        contentView.addSubview(containerStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerStackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
