//
//  BaseQueryStringRequestModel.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

struct BaseQueryStringRequestModel: Encodable {
    let apiKey: String?
    let language: String?
    let page: String?
    let region: String?
    let query: String?
    
    init(apiKey: String? = nil,
         language: String? = nil,
         page: String? = nil,
         region: String? = nil,
         query: String? = nil) {
        self.apiKey = apiKey
        self.language = language
        self.page = page
        self.region = region
        self.query = query
    }
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case language = "language"
        case page = "page"
        case region = "region"
        case query = "query"
    }
}
