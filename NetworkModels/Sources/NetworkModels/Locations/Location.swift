//
//  Location.swift
//  NetworkModels
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

public struct Location: Decodable {
    public let name: String?
    public let latitude: Double?
    public let longitude: Double?

    public init(name: String?, latitude: Double?, longitude: Double?) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }

    enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
}
