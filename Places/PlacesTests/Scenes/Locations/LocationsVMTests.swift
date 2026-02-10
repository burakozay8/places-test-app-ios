//
//  LocationsVMTests.swift
//  PlacesTests
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import XCTest
@testable import Places
import NetworkModels

@MainActor
final class LocationsVMTests: XCTestCase {

    var sut: LocationsVM!

    override func setUp() {
        super.setUp()
        sut = LocationsVM()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_LocationListIsEmpty() async throws {
        XCTAssertTrue(sut.locations.isEmpty)
        let response = try createResponse("locations")
        await fetchLocations(response: response)

        XCTAssertEqual(sut.state, .success)
        XCTAssertFalse(sut.locations.isEmpty)
    }

    func test_LocationListCount() async throws {
        XCTAssertTrue(sut.locations.isEmpty)
        let response = try createResponse("locations")
        await fetchLocations(response: response)
        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.locations.count, 4)
    }

    func test_LocationListItems() async throws {
        let response = try createResponse("locations")
        await fetchLocations(response: response)
        let firstItem = try XCTUnwrap(sut.locations.first)
        XCTAssertEqual(firstItem.name, "Amsterdam")
        XCTAssertEqual(firstItem.latitude, 52.3547498)
        XCTAssertEqual(firstItem.longitude, 4.8339215)
        let lastItem = try XCTUnwrap(sut.locations.last)
        XCTAssertNil(lastItem.name)
        XCTAssertEqual(lastItem.latitude, 40.4380638)
        XCTAssertEqual(lastItem.longitude, -3.7495758)
    }

    func test_LocationListItemsWithStoredLocation() async throws {
        let stored = [
            Location(name: "Istanbul", latitude: 41.01, longitude: 28.97)
        ]
        let response = try createResponse("locations")
        await fetchLocations(response: response, stored: stored)

        XCTAssertEqual(sut.locations.count, 5)

        let lastItem = try XCTUnwrap(sut.locations.last)
        XCTAssertEqual(lastItem.name, "Istanbul")
        XCTAssertEqual(lastItem.latitude, 41.01)
        XCTAssertEqual(lastItem.longitude, 28.97)
    }

    func test_EmptyState() async throws {
        let response = try createResponse("locations_empty")
        await fetchLocations(response: response)
        XCTAssertTrue(sut.locations.isEmpty)
        XCTAssertEqual(sut.state, .empty)
    }

    func test_ErrorState() async {
        let service = FailingLocationsService()
        let store = MockLocationsStore(stored: [])
        sut = LocationsVM(service: service, store: store)

        await sut.fetchLocations()

        XCTAssertEqual(sut.state, .error)
        XCTAssertTrue(sut.locations.isEmpty)
    }


    private func fetchLocations(response: LocationsResponse, stored: [Location] = []) async {
        let service = MockLocationsService(response: response)
        let store = MockLocationsStore(stored: stored)
        sut = LocationsVM(service: service, store: store)
        await sut.fetchLocations()
    }

    private func createResponse(_ fileName: String) throws -> LocationsResponse {
        let bundle = Bundle(for: LocationsVMTests.self)
        let response = try JSONLoader.load(LocationsResponse.self, fileName: fileName, bundle: bundle)
        return response
    }
}
