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
        HStack(alignment: .top, spacing: Constant.hStackSpacing) {
            VStack(alignment: .leading, spacing: Constant.vStackSpacing) {
                Text(model.title)
                    .font(.headline)

                Text(model.latitudeText)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(model.longitudeText)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button(Constant.buttonName) {
                onButtonTap()
            }
            .font(.subheadline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: Constant.cornerRadius)
                .fill(Color(.secondarySystemBackground))
        )
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
        var latitudeText: String { "latitude: \(location.latitude ?? 0.0)" }
        var longitudeText: String { "longitude: \(location.longitude ?? 0.0)" }
    }
}

// MARK: - Constant
private extension LocationRowView {
    enum Constant {
        static let hStackSpacing: CGFloat = 12
        static let vStackSpacing: CGFloat = 4
        static let cornerRadius: CGFloat = 12
        static let emptyTitle = "Unknown"
        static let buttonName = "Explore on Wiki"
    }
}
