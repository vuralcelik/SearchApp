//
//  MovieRouter.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Alamofire

enum MovieRouter: RouterProvider {
    case popular(queryStringRequest: BaseQueryStringRequestModel)
    case credits(pathVariableRequest: MovieCreditsPathVariableRequestModel,
                 queryStringRequest: BaseQueryStringRequestModel)

    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .credits:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/movie/popular"
        case .credits(let pathVariableRequest, _):
            return "/movie/\(pathVariableRequest.id)/credits"
        }
    }

    var queryParameters: QueryStringParameters {
        switch self {
        case .popular(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        case .credits(_, let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        }
    }

    var httpBody: Data? {
        switch self {
        case .popular:
            return nil
        case .credits:
            return nil
        }
    }

    var headers: [CustomHTTPHeader]? {
        switch self {
        case .popular:
            return [.contentType]
        case .credits:
            return [.contentType]
        }
    }
}
