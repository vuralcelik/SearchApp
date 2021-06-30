//
//  PeopleDetailResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 29.06.2021.
//

import Foundation

struct PeopleDetailResponseModel: Decodable {
    let id: Int?
    let name: String?
    let biography: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case biography
        case profilePath = "profile_path"
    }
    
    init(id: Int? = nil,
         name: String? = nil,
         biography: String? = nil,
         profilePath: String? = nil) {
        self.id = id
        self.name = name
        self.biography = biography
        self.profilePath = profilePath
    }
    
}
