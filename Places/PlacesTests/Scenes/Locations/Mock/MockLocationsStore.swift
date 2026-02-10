//
//  MockLocationsStore.swift
//  Places
//
//  Created by BURAKHAN OZAY on 10.02.2026.
//

import NetworkModels
@testable import Places

struct MockLocationsStore: LocationsStoring {
    let stored: [Location]
    func loadStoredLocations() -> [Location] { stored }
    func save(_ location: Location) {}
}
