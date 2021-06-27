//
//  MovieResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

struct MovieResponseModel: Decodable {
    let posterPath: String?
    let releaseDate: String?
    let id: Int?
    let originalTitle: String?
    let title: String?
    let voteAverage: Double?
    let overview: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case id
        case originalTitle = "original_title"
        case title
        case voteAverage = "vote_average"
        case overview = "overview"
    }
}
