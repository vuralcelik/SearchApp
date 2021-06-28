//
//  CoverPhotoCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class CoverPhotoCell: BaseTableViewCell {
    //MARK: - Views
    lazy var coverPhotoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    //MARK: - Computed Properties
    var movieModel: MovieResponseModel? {
        didSet {
            guard let validatedMovieModel = movieModel else { return }
            coverPhotoImageView.setImageWithCaching(urlString: validatedMovieModel.posterPath)
        }
    }
    
    //MARK: - Life Cycle
    override func commonInit() {
        super.commonInit()
        
    }
    
    //MARK: - UI Configuration
    override func setupViews() {
        super.setupViews()
        contentView.addSubview(coverPhotoImageView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        coverPhotoImageView.snp.makeConstraints { (make) in
            make.width.equalTo(175)
            make.height.equalTo(305)
            make.edges.equalToSuperview()
        }
    }
}
