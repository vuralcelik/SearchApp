//
//  OnlyMovieCell.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import UIKit

class OnlyMovieCell: BaseTableViewCell {
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
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .clear
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
        view.textAlignment = .left
        view.numberOfLines = 0
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
    var movieModel: MovieResponseModel? {
        didSet {
            guard let validatedMovieModel = movieModel else { return }
            movieTitleLabel.text = (validatedMovieModel.title ?? "") + ", " + (validatedMovieModel.releaseDate ?? "")
            movieVoteLabel.text = validatedMovieModel.voteAverage?.description
            moviePosterImageView.setImageWithCaching(urlString: validatedMovieModel.posterPath)
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
            make.edges.equalToSuperview().inset(32)
        }
        
        moviePosterImageView.snp.makeConstraints { (make) in
            make.width.equalTo(350)
            make.height.equalTo(611)
        }
    }
}
