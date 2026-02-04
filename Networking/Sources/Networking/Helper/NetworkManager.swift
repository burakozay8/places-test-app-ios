//
//  NetworkManager.swift
//  Networking
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation

public protocol NetworkManaging {
    func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async throws -> T
}

public extension NetworkManaging {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        try await request(endpoint, as: T.self)
    }
}

public struct NetworkManager: NetworkManaging {
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }

    public func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async throws -> T {
        let request = try URLRequestBuilder().build(from: endpoint)

        do {
            let (data, response) = try await session.data(for: request)

            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200...299).contains(http.statusCode) else {
                throw NetworkError.httpStatus(http.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decoding(error)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.transport(error)
        }
    }
}
