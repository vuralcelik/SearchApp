//
//  SearchRouter.swift
//  SearchApp
//
//  Created by Vural Çelik on 27.06.2021.
//

import Alamofire

enum SearchRouter: RouterProvider {
    case mutliSearch(queryStringRequest: BaseQueryStringRequestModel)

    var method: HTTPMethod {
        switch self {
        case .mutliSearch:
            return .get
        }
    }

    var path: String {
        switch self {
        case .mutliSearch:
            return "/search/multi"
        }
    }

    var queryParameters: QueryStringParameters {
        switch self {
        case .mutliSearch(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        }
    }

    var httpBody: Data? {
        switch self {
        case .mutliSearch:
            return nil
        }
    }

    var headers: [CustomHTTPHeader]? {
        switch self {
        case .mutliSearch:
            return [.contentType]
        }
    }
}
