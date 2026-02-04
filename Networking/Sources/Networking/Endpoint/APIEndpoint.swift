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

// TODO: - Clarify, in terms of generic usage, whether these default implementations are appropriate.
public extension APIEndpoint {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
}
