//
//  Location.swift
//  NetworkModels
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation

public struct Location: Decodable, Sendable, Identifiable {
    public let id = UUID()
    public let name: String?
    public let latitude: Double?
    public let longitude: Double?

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}
