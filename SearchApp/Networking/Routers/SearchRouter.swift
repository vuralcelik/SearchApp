//
//  SearchRouter.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import Alamofire

enum SearchRouter: RouterProvider {
    case movies(queryStringRequest: BaseQueryStringRequestModel)
    case people(queryStringRequest: BaseQueryStringRequestModel)

    var method: HTTPMethod {
        switch self {
        case .movies:
            return .get
        case .people:
            return .get
        }
    }

    var path: String {
        switch self {
        case .movies:
            return "/search/movie"
        case .people:
            return "/search/person"
        }
    }

    var queryParameters: QueryStringParameters {
        switch self {
        case .movies(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        case .people(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        }
    }

    var httpBody: Data? {
        switch self {
        case .movies:
            return nil
        case .people:
            return nil
        }
    }

    var headers: [CustomHTTPHeader]? {
        switch self {
        case .movies:
            return [.contentType]
        case .people:
            return [.contentType]
        }
    }
}
