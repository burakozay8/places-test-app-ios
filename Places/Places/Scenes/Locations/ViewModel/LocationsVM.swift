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

    @Published private(set) var state: ViewState = .unknown
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

    func createWikipediaPlacesDeeplinkUrl(latitude: Double?, longitude: Double?) -> URL? {
        guard let latitude, let longitude else { return nil }

        var components = URLComponents()
        components.scheme = Constant.wikipediaAppDeeplinkScheme
        components.host = Constant.wikipediaAppDeeplinkHost
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude))
        ]

        return components.url
    }
}

private extension LocationsVM {
    enum Constant {
        static let wikipediaAppDeeplinkScheme = "wikipedia"
        static let wikipediaAppDeeplinkHost = "places"
    }
}

// TODO: Move to another file
enum ViewState {
    case unknown
    case loading
    case empty
    case success
    case error
}
