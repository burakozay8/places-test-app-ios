//
//  AddLocationSheetVM.swift
//  Places
//
//  Created by BURAKHAN OZAY on 6.02.2026.
//

import Foundation
import NetworkModels
import Combine

@MainActor
final class AddLocationSheetVM: ObservableObject {

    // MARK: - AddLocationField
    enum AddLocationField {
        case name
        case latitude
        case longitude
    }

    // MARK: - Properties
    @Published private(set) var touched: Set<AddLocationField> = []
    @Published var name = ""
    @Published var latitude = ""
    @Published var longitude = ""

    var isInputValid: Bool { latitudeError == nil && longitudeError == nil }
    var latitudeError: String? { validateLatitude(latitude) }
    var longitudeError: String? { validateLongitude(longitude) }

    // MARK: - Functions
    func markTouched(_ field: AddLocationField) {
        touched.insert(field)
    }

    func shouldShowError(for field: AddLocationField) -> Bool {
        touched.contains(field)
    }

    func makeLocation() -> Location? {
        guard isInputValid,
              let lat = Double(latitude),
              let lon = Double(longitude) else { return nil }
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : name

        return Location(
            name: name,
            latitude: lat,
            longitude: lon
        )
    }

    // MARK: - Private Functions
    private func validateCoordinate(
        _ text: String,
        requiredMessage: String,
        notNumberMessage: String,
        outOfRangeMessage: String,
        range: ClosedRange<Double>
    ) -> String? {
        guard !text.isEmpty else { return requiredMessage }
        guard let value = Double(text) else { return notNumberMessage }
        return range.contains(value) ? nil : outOfRangeMessage
    }

    private func validateLatitude(_ text: String) -> String? {
        validateCoordinate(
            text,
            requiredMessage: Constant.latitudeRequiredError,
            notNumberMessage: Constant.latitudeNotNumberError,
            outOfRangeMessage: Constant.latitudeOutOfRangeError,
            range: Constant.latitudeRange
        )
    }

    private func validateLongitude(_ text: String) -> String? {
        validateCoordinate(
            text,
            requiredMessage: Constant.longitudeRequiredError,
            notNumberMessage: Constant.longitudeNotNumberError,
            outOfRangeMessage: Constant.longitudeOutOfRangeError,
            range: Constant.longitudeRange
        )
    }
}

private extension AddLocationSheetVM {
    enum Constant {
        // Latitude
        static let latitudeRequiredError = "Latitude is required."
        static let latitudeNotNumberError = "Latitude must be a number."
        static let latitudeOutOfRangeError = "Latitude must be between -90 and 90."
        static let latitudeRange: ClosedRange<Double> = -90.0...90.0

        // Longitude
        static let longitudeRequiredError = "Longitude is required."
        static let longitudeNotNumberError = "Longitude must be a number."
        static let longitudeOutOfRangeError = "Longitude must be between -180 and 180."
        static let longitudeRange: ClosedRange<Double> = -180.0...180.0
    }
}
