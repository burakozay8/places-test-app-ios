//
//  LocationsVM.swift
//  Places
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import Foundation
import Combine
import NetworkModels

@MainActor
final class LocationsVM: ObservableObject {

    @Published private(set) var state: State = .unknown
    @Published private(set) var locations: [Location] = []

    private let service: LocationsServicing

    init(service: LocationsServicing) {
        self.service = service
    }

    convenience init() {
        self.init(service: LocationsService())
    }

    func fetchLocations() async {
        state = .loading
        do {
            let response = try await service.fetchLocations()
            locations = response.locations ?? []
            state = locations.isEmpty ? .empty : .success
        } catch {
            state = .error
        }
    }
}

// TODO: Move to another file
enum State {
    case unknown
    case loading
    case empty
    case success
    case error
}
