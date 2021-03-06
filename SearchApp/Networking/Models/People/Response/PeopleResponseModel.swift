//
//  PeopleResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

struct PeopleResponseModel: Decodable {
    let profilePath: String?
    let name: String?
    let id: Int?
}
