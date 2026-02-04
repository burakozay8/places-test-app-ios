//
//  URLRequestBuilder.swift
//  Networking
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation

public struct URLRequestBuilder {
    public func build(from endpoint: APIEndpoint) throws -> URLRequest {
        guard var components = URLComponents(string: endpoint.baseURL) else {
            throw NetworkError.invalidURL
        }

        components.path = endpoint.path

        if let queryItems = endpoint.queryItems, !queryItems.isEmpty {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        urlRequest.allHTTPHeaderFields = endpoint.headers

        if let body = endpoint.body {
            urlRequest.httpBody = body
        }

        return urlRequest
    }
}
