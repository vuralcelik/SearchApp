//
//  PeopleRouter.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Alamofire

enum PeopleRouter: RouterProvider {
    case popular(queryStringRequest: BaseQueryStringRequestModel)

    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/person/popular"
        }
    }

    var queryParameters: QueryStringParameters {
        switch self {
        case .popular(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        }
    }

    var httpBody: Data? {
        switch self {
        case .popular:
            return nil
        }
    }

    var headers: [CustomHTTPHeader]? {
        switch self {
        case .popular:
            return [.contentType]
        }
    }
}
