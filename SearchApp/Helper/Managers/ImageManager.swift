//
//  ImageManager.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import Kingfisher

class ImageManager {
    static func setImage(imageView: UIImageView, urlString: String?) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500" + (urlString ?? "")) else { return }
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                        |> RoundCornerImageProcessor(cornerRadius: 12)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .processor(processor),
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.flipFromRight(0.25))
            ]
        )
    }
}
