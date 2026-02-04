//
//  LocationsResponse.swift
//  NetworkModels
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

public struct locationsResponse: Decodable {
    let locations: [Location]?

    public init(locations: [Location]?) {
        self.locations = locations
    }
}
