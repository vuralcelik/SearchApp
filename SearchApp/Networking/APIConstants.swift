//
//  APIConstants.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation

//API KEY d5155429a4ca75afc8742180a5108788

struct APIConstants {
    static var baseURL: String {
        #if DEBUG
            return "https://api.themoviedb.org/3"
        #else
            return "https://api.themoviedb.org/3"
        #endif
    }
}

enum CustomHTTPHeader: String {
    case contentType

    var key: String {
        switch self {
        case .contentType: return "Content-Type"
        }
    }

    var value: String {
        switch self {
        case .contentType: return "application/json"
        }
    }
}
