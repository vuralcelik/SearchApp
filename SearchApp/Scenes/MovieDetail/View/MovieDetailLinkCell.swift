//
//  MovieDetailLinkCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class MovieDetailLinkCell: BaseTableViewCell {
    //MARK: - Views
    lazy var movieVideoLinkLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - Computed Properties
    var movieModel: MovieResponseModel? {
        didSet {
            
        }
    }
    
    //MARK: - Life Cycle
    override func commonInit() {
        super.commonInit()
        
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(movieVideoLinkLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        movieVideoLinkLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
