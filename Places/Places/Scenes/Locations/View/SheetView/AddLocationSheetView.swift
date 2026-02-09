//
//  AddLocationSheetView.swift
//  Places
//
//  Created by BURAKHAN OZAY on 6.02.2026.
//

import SwiftUI
import NetworkModels

struct AddLocationSheetView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focus: AddLocationSheetVM.AddLocationField?
    @StateObject private var viewModel = AddLocationSheetVM()

    let onSave: (Location) -> Void

    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ValidatableTextField(
                    model: .init(
                        title: Constant.nameTextFieldPlaceHolderText,
                        text: $viewModel.name,
                        focus: $focus,
                        accessibilityLabel: AccessibilityLabel.nameField.rawValue,
                        accessibilityHint: .nameField
                    )
                )
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

                ValidatableTextField(
                    model: .init(
                        title: Constant.latitudeTextFieldPlaceHolderText,
                        text: $viewModel.latitude,
                        focus: $focus,
                        keyboard: .numbersAndPunctuation,
                        error: viewModel.shouldShowError(for: .latitude) ? viewModel.latitudeError : nil,
                        focusField: .latitude,
                        accessibilityLabel: Constant.latitudeTextFieldPlaceHolderText,
                        accessibilityHint: .latitudeField,
                    )
                )
                .onChange(of: viewModel.latitude) {
                    viewModel.latitude = viewModel.latitude.replacingOccurrences(of: ",", with: ".")
                }

                ValidatableTextField(
                    model: .init(
                        title: Constant.longitudeTextFieldPlaceHolderText,
                        text: $viewModel.longitude,
                        focus: $focus,
                        keyboard: .numbersAndPunctuation,
                        error: viewModel.shouldShowError(for: .longitude) ? viewModel.longitudeError : nil,
                        focusField: .longitude,
                        accessibilityLabel: Constant.longitudeTextFieldPlaceHolderText,
                        accessibilityHint: .longitudeField,
                    )
                )
                .onChange(of: viewModel.longitude) {
                    viewModel.longitude = viewModel.longitude.replacingOccurrences(of: ",", with: ".")
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .navigationTitle(Constant.navigationBarTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Constant.saveButtonTitle) {
                        guard let location = viewModel.makeLocation() else { return }
                        onSave(location)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!viewModel.isInputValid)
                    .accessibilityLabel(Constant.saveButtonTitle)
                    .accessibilityHint(
                        viewModel.isInputValid ? AccessibilityHint.saveEnabled.rawValue : AccessibilityHint.saveDisabled.rawValue
                    )
                }

                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(Constant.doneButtonTitle) {
                        focus = nil
                    }
                    .accessibilityLabel(Constant.doneButtonTitle)
                    .accessibilityHint(AccessibilityHint.doneButton.rawValue)
                }
            }
            .onChange(of: focus) { oldValue, newValue in
                if let oldValue, newValue != oldValue {
                    viewModel.markTouched(oldValue)
                }
                if newValue == nil, let oldValue {
                    viewModel.markTouched(oldValue)
                }
            }
        }
    }
}

// MARK: - Constant
private extension AddLocationSheetView {
    enum Constant {
        static let nameTextFieldPlaceHolderText = "Name (optional)"
        static let latitudeTextFieldPlaceHolderText = "Latitude"
        static let longitudeTextFieldPlaceHolderText = "Longitude"
        static let navigationBarTitle = "Add Location"
        static let saveButtonTitle = "Save"
        static let doneButtonTitle = "Done"
    }
}
