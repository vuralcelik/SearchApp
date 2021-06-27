//
//  MultiSearchResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import Foundation

struct MultiSearchResponseModel: Decodable {
    let posterPath: String?
    let popularity: Double
    let id: Int
    let overview: String?
    let backdropPath: String?
    let voteAverage: Double?
    let mediaType: MediaType
    let firstAirDate: String?
    let originCountry: [String]?
    let genreIDS: [Int]?
    let voteCount: Int?
    let name, originalName: String?
    let adult: Bool?
    let releaseDate, originalTitle, title: String?
    let video: Bool?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity, id, overview
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case mediaType = "media_type"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case adult
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case title, video
        case profilePath = "profile_path"
    }
}

enum MediaType: String, Decodable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}
