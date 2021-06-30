//
//  MovieCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import UIKit

class MovieCell: BaseCollectionViewCell {
    //MARK: - Views
    lazy var containerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [moviePosterImageView,
                                                  informationContainerStackView])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    lazy var moviePosterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var informationContainerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [movieTitleLabel,
                                                  movieVoteLabel])
        view.backgroundColor = .clear
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 0
        return view
    }()
    
    lazy var movieTitleLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.numberOfLines = 1
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    lazy var movieVoteLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .clear
        view.textAlignment = .right
        view.numberOfLines = 1
        view.font = FontFamily.SourceSansPro.bold.font(size: 16)
        view.textColor = ColorName.customBlack.color
        return view
    }()
    
    //MARK: - Computed Properties
    var movieSearchModel: MovieResponseModel? {
        didSet {
            guard let validatedMovieSearchModel = movieSearchModel else { return }
            movieTitleLabel.text = (validatedMovieSearchModel.title ?? "") + ", " + (validatedMovieSearchModel.releaseDate ?? "")
            movieVoteLabel.text = validatedMovieSearchModel.voteAverage?.description
            moviePosterImageView.setImageWithCaching(urlString: validatedMovieSearchModel.posterPath)
        }
    }
    
    var castModel: MovieResponseModel? {
        didSet {
            guard let validatedCastModel = castModel else { return }
            movieTitleLabel.text = validatedCastModel.title
            movieVoteLabel.text = validatedCastModel.voteAverage?.description
            moviePosterImageView.setImageWithCaching(urlString: validatedCastModel.posterPath)
        }
    }
    
    //MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        moviePosterImageView.image = nil
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
        
        moviePosterImageView.snp.makeConstraints { (make) in
            make.width.equalTo(175)
            make.height.equalTo(305)
        }
    }
}
