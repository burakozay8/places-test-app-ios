//
//  LocationsView.swift
//  Places
//
//  Created by BURAKHAN OZAY on 4.02.2026.
//

import SwiftUI
import NetworkModels

struct LocationsView: View {

    // MARK: - Properties
    @StateObject private var viewModel = LocationsVM()

    //MARK: - Body
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(Constant.navigationTitle)
                .safeAreaInset(edge: .bottom) {
                    addLocationButton
                }
        }
        .task {
            await viewModel.fetchLocations()
        }
    }
}

// MARK: - Content
private extension LocationsView {

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .unknown, .loading:
            // TODO: - Improve loading state view
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .empty:
            // TODO: - Improve empty state view
            Text("No locations found!")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .success:
            locationsList
        case .error:
            // TODO: - Improve error state
            Text("Something went wrong")
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: - Location List
private extension LocationsView {
    var locationsList: some View {
        ScrollView {
            LazyVStack(spacing: Constant.locationsListVStackViewSpacing) {
                ForEach(viewModel.locations) { location in
                    LocationRowView(
                        model: .init(location: location),
                        onButtonTap: {
                            if let url = viewModel.createWikipediaPlacesDeeplinkUrl(
                                latitude: location.latitude,
                                longitude: location.longitude
                            ) {
                                UIApplication.shared.open(url)
                            }
                        }
                    )
                }
            }
            .padding()
        }
    }
}

// MARK: - Add Location Button
private extension LocationsView {
    var addLocationButton: some View {
        Button {
//            isAddLocationPresented = true
        } label: {
            Text(Constant.addLocationsButtonTitle)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .frame(height: Constant.addLocationsButtonHeight)
        .buttonStyle(.borderedProminent)
        .padding()
    }
}

private extension LocationsView {
    enum Constant {
        static let navigationTitle = "Locations"
        static let locationsListVStackViewSpacing: CGFloat = 12
        static let addLocationsButtonTitle = "Add Location"
        static let addLocationsButtonHeight: CGFloat = 48
    }
}
