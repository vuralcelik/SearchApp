//
//  BasePaginationResponseModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

struct BasePaginationResponseModel<T: Decodable>: Decodable {
    let page: Int?
    let results: [T]?
    let totalResults, totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
