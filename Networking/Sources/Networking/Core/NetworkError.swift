//
//  NetworkError.swift
//  Networking
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)
    case transport(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response."
        case .httpStatus(let code):
            return "HTTP error: \(code)."
        case .decoding(let error):
            return "Decoding failed: \(error.localizedDescription)"
        case .transport(let error):
            return "Network request failed: \(error.localizedDescription)"
        }
    }
}
