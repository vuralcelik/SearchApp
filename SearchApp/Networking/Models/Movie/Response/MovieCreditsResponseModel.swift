//
//  PeopleDetailMovieCreditsResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 29.06.2021.
//

import Foundation

// MARK: - Welcome
struct MovieCreditsResponseModel: Decodable {
    let cast: [MovieResponseModel]?
    let id: Int?
    
    init(cast: [MovieResponseModel]? = nil,
         id: Int? = nil) {
        self.cast = cast
        self.id = id
    }
}
