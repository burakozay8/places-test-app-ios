//
//  LocationsResponse.swift
//  NetworkModels
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

public struct LocationsResponse: Decodable, Sendable {
    public let locations: [Location]?
}
