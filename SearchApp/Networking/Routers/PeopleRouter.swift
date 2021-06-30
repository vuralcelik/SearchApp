//
//  PeopleRouter.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Alamofire

enum PeopleRouter: RouterProvider {
    case popular(queryStringRequest: BaseQueryStringRequestModel)
    case detail(pathVariableRequest: PeopleDetailPathVariableRequestModel,
                queryStringRequest: BaseQueryStringRequestModel)
    case movieCredits(pathVariableRequest: PeopleDetailPathVariableRequestModel,
                      queryStringRequest: BaseQueryStringRequestModel)

    var method: HTTPMethod {
        switch self {
        case .popular:
            return .get
        case .detail:
            return .get
        case .movieCredits:
            return .get
        }
    }

    var path: String {
        switch self {
        case .popular:
            return "/person/popular"
        case .detail(let pathVariableRequest, _):
            return "/person/\(pathVariableRequest.personId)"
        case .movieCredits(let pathVariableRequest, _):
            return "/person/\(pathVariableRequest.personId)/movie_credits"
        }
    }

    var queryParameters: QueryStringParameters {
        switch self {
        case .popular(let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        case .detail(_, let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        case .movieCredits(_, let queryStringRequest):
            return queryStringRequest.asDictionaryForQueryString
        }
    }

    var httpBody: Data? {
        switch self {
        case .popular:
            return nil
        case .detail:
            return nil
        case .movieCredits:
            return nil
        }
    }

    var headers: [CustomHTTPHeader]? {
        switch self {
        case .popular:
            return [.contentType]
        case .detail:
            return [.contentType]
        case .movieCredits:
            return [.contentType]
        }
    }
}
