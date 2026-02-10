//
//  MockLocationsService.swift
//  Places
//
//  Created by BURAKHAN OZAY on 10.02.2026.
//

import NetworkModels
@testable import Places

struct MockLocationsService: LocationsServicing {
    let response: LocationsResponse

    func fetchLocations() async throws -> LocationsResponse { response }
}

struct FailingLocationsService: LocationsServicing {
    struct DummyError: Error {}
    func fetchLocations() async throws -> LocationsResponse { throw DummyError() }
}
