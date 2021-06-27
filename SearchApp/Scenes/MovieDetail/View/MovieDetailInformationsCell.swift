//
//  MovieDetailInformationsCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class MovieDetailInformationsCell: BaseTableViewCell {
    //MARK: - Views
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieTitleLabel,
                                                  movieOverviewLabel,
                                                  movieVoteLabel])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 4
        return view
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var movieOverviewLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 0
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var movieVoteLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = FontFamily.SourceSansPro.semiBold.font(size: 14)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - Computed Properties
    var movieModel: MovieResponseModel? {
        didSet {
            guard let validatedMovieModel = movieModel else { return }
            movieTitleLabel.text = "Name: " + (validatedMovieModel.title ?? "-")
            movieOverviewLabel.text = "Overview: \n" + (validatedMovieModel.overview ?? "-")
            movieVoteLabel.text = "Average Vote: " + (validatedMovieModel.voteAverage?.description ?? "-")
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
