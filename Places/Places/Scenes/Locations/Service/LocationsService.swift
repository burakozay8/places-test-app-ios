//
//  LocationsService.swift
//  Places
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation
import Networking
import NetworkModels

protocol LocationsServicing {
    func fetchLocations() async throws -> LocationsResponse
}

final class LocationsService: LocationsServicing {

    enum LocationsAPI: APIEndpoint {
        case locations

        var baseURL: String { "https://raw.githubusercontent.com" }
        var path: String {
            switch self {
            case .locations:
                return "/abnamrocoesd/assignment-ios/main/locations.json"
            }
        }
        var method: HTTPMethod { .get }
    }

    private let networkManager: NetworkManaging

    init(networkManager: NetworkManaging = NetworkManager()) {
        self.networkManager = networkManager
    }

    func fetchLocations() async throws -> LocationsResponse {
        return try await networkManager.request(LocationsAPI.locations)
    }
}
