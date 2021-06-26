//
//  RouterProvider.swift
//  SearchApp
//
//  Created by Vural Çelik on 26.06.2021.
//

import Foundation
import Alamofire

typealias QueryStringParameters = [String: String]?

protocol RouterProvider: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var queryParameters: QueryStringParameters { get }
    var httpBody: Data? { get }
    var headers: [CustomHTTPHeader]? { get }
}

extension RouterProvider {
    func asURLRequest() throws -> URLRequest {
        let url = try (APIConstants.baseURL + path).asURL()
        
        var urlComponents = URLComponents(string: url.absoluteString)
        
        //Query Parameters
        urlComponents?.queryItems = queryParameters?.map { key, value in
            return URLQueryItem(name: key, value: value)
        }

        var urlRequest = URLRequest(url: (urlComponents?.url!)!)

        //HTTP Method
        urlRequest.httpMethod = method.rawValue

        //Headers
        headers?.forEach({ header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        })

        //Parameters
        urlRequest.httpBody = httpBody

        return urlRequest
    }
}
