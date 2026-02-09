//
//  APIEndpoint.swift
//  Networking
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation

public protocol APIEndpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }

    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

public extension APIEndpoint {
    var baseURL: String { "https://raw.githubusercontent.com" }
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}
