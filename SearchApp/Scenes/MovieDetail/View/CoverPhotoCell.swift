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
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .red
        return view
    }()
    
    //MARK: - Computed Properties
    var movieModel: MovieResponseModel? {
        didSet {
            guard let validatedMovieModel = movieModel else { return }
            ImageManager.setImage(imageView: coverPhotoImageView, urlString: validatedMovieModel.posterPath)
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
            make.edges.equalToSuperview().inset(32)
            make.width.equalTo(coverPhotoImageView.snp.height).multipliedBy(0.5)
        }
    }
}
