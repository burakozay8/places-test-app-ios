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
    @State private var isAddLocationPresented = false

    //MARK: - Body
    var body: some View {
        NavigationStack {
            content
                .navigationTitle(Constant.navigationTitle)
                .safeAreaInset(edge: .bottom) {
                    addLocationButton
                }
                .sheet(isPresented: $isAddLocationPresented) {
                    AddLocationSheetView { location in
                        viewModel.addLocation(location)
                    }
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .accessibilityAddTraits(.isModal)
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
            VStack(spacing: 12) {
                ProgressView()
                Text(Constant.loadingTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .empty:
            CenterStateView(
                model: .init(
                    title: Constant.emptyLabelTitle,
                    accessibilityLabel: .empty,
                    accessibilityHint: .empty
                )
            )
        case .success:
            locationsList
        case .error:
            CenterStateView(
                model: .init(
                    title: Constant.errorLabelTitle,
                    accessibilityLabel: .empty,
                    accessibilityHint: .empty
                )
            )
        }
    }
}

// MARK: - Location List
private extension LocationsView {
    var locationsList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.locations) { location in
                    LocationRowView(
                        model: .init(location: location),
                        onButtonTap: {
                            if let url = viewModel.createWikipediaPlacesDeeplinkUrl(
                                latitude: location.latitude,
                                longitude: location.longitude
                            ) {
                                UIApplication.openURL(url, failure: {
                                    guard let url = URL(string: Constant.wikipediaAppStoreUrlString) else { return }
                                    UIApplication.openURL(url)
                                })
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
            isAddLocationPresented = true
        } label: {
            Text(Constant.addLocationsButtonTitle)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .frame(height: 48)
        .buttonStyle(.borderedProminent)
        .padding()
        .accessibilityLabel(AccessibilityLabel.addLocation.rawValue)
        .accessibilityHint(AccessibilityHint.addLocation.rawValue)
    }
}

// MARK: - Constant
private extension LocationsView {
    enum Constant {
        static let navigationTitle = "Locations"
        static let loadingTitle = "Loading..."
        static let emptyLabelTitle = "No locations found!"
        static let errorLabelTitle = "Something went wrong 😕"
        static let addLocationsButtonTitle = "Add Location"
        static let wikipediaAppStoreUrlString = "https://apps.apple.com/app/wikipedia/id324715238"
    }
}
