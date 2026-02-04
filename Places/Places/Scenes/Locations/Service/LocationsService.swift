//
//  LocationsService.swift
//  Places
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation
import Networking
import NetworkModels

final class LocationsService {
    private let networkManager = NetworkManager()

    func fetchLocations() async throws -> LocationsResponse {
        return try await networkManager.request(LocationsAPI.locations)
    }
}

private enum LocationsAPI {
    case locations
}

extension LocationsAPI: APIEndpoint {
    var baseURL: String { "https://raw.githubusercontent.com" }
    var path: String {
        switch self {
        case .locations:
            return "/abnamrocoesd/assignment-ios/main/locations.json"
        }
    }
    var method: HTTPMethod { .get }
}
