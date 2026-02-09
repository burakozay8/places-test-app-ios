//
//  LocationsRowView.swift
//  Places
//
//  Created by BURAKHAN OZAY on 5.02.2026.
//

import SwiftUI
import NetworkModels

struct LocationRowView: View {

    // MARK: - Dependencies
    let model: Model
    let onButtonTap: () -> Void

    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(model.title)
                    .font(.headline)
                    .accessibilityLabel(model.title)

                Text(model.latitudeText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(model.accessibilityLatitude)

                Text(model.longitudeText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .accessibilityLabel(model.accessibilityLongitude)
            }

            Spacer()

            Button(Constant.buttonName) {
                onButtonTap()
            }
            .font(.subheadline)
            .accessibilityLabel(model.accessibilityButtonLabel)
            .accessibilityHint(AccessibilityHint.openWikipedia.rawValue)
            .accessibilityAddTraits(.isButton)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        .accessibilityElement(children: .contain)
    }
}

//MARK: - Model
extension LocationRowView {
    struct Model {
        private let location: Location

        init(location: Location) {
            self.location = location
        }

        var title: String { location.name ?? Constant.emptyTitle }
        var latitudeText: String { "\(Constant.latitudePrefix): \(location.latitude ?? 0.0)" }
        var longitudeText: String { "\(Constant.longitudePrefix): \(location.longitude ?? 0.0)" }

        var accessibilityLatitude: String {
            "\(Constant.latitudePrefix) \(format(location.latitude ?? 0.0))"
        }

        var accessibilityLongitude: String {
            "\(Constant.longitudePrefix) \(format(location.longitude ?? 0.0))"
        }

        var accessibilityButtonLabel: String {
            let name = location.name ?? Constant.unknownNameForButton
            return "\(Constant.openButtonTemplatePrefix) \(name) \(Constant.openButtonTemplateSuffix)"
        }

        private func format(_ value: Double) -> String {
            String(format: Constant.numberFormat, value)
        }
    }
}

// MARK: - Constant
private extension LocationRowView {
    enum Constant {
        static let emptyTitle = "Unnamed Location"
        static let buttonName = "Explore on Wikipedia"
        static let unknownNameForButton = "this location"
        static let latitudePrefix = "Latitude"
        static let longitudePrefix = "Longitude"
        static let openButtonTemplatePrefix = "Open"
        static let openButtonTemplateSuffix = "in Wikipedia Places"
        static let numberFormat = "%.4f"
    }
}
