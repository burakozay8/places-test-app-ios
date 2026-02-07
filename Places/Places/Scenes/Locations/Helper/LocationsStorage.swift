//
//  LocationsStorage.swift
//  Places
//
//  Created by BURAKHAN OZAY on 7.02.2026.
//

import Storage
import NetworkModels

protocol LocationsStoring {
    func loadStoredLocations() -> [Location]
    func save(_ location: Location)
}

final class LocationsStorage: LocationsStoring {

    private let storage: KeyValueStoring
    private let key = "saved_locations"

    init(storage: KeyValueStoring = UserDefaultsStorage()) {
        self.storage = storage
    }

    func loadStoredLocations() -> [Location] {
        storage.load([Location].self, forKey: key) ?? []
    }

    func save(_ location: Location) {
        var locations = loadStoredLocations()
        locations.append(location)
        storage.save(locations, forKey: key)
    }
}
