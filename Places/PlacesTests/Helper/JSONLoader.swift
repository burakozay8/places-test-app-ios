//
//  JSONLoader.swift
//  Places
//
//  Created by BURAKHAN OZAY on 10.02.2026.
//

import Foundation

struct JSONLoader {
    static func load<T: Decodable>(
        _ type: T.Type,
        fileName: String,
        bundle: Bundle
    ) throws -> T {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw NSError(domain: "JSONLoader", code: 1, userInfo: [NSLocalizedDescriptionKey: "Missing \(fileName).json in bundle"])
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
