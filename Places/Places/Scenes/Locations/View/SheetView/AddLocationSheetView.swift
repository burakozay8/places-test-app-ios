//
//  AddLocationSheetView.swift
//  Places
//
//  Created by BURAKHAN OZAY on 6.02.2026.
//

import SwiftUI
import Combine

struct AddLocationSheetView: View {

    // MARK: - Properties
    @Environment(\.dismiss) private var dismiss

    @FocusState private var focus: Field?

    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""

    // MARK: - Field Enum
    enum Field { case name, lat, lon }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField(Constant.nameTextFieldPlaceHolderText, text: $name)
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                        .focused($focus, equals: .name)
                    TextField(Constant.latitudeTextFieldPlaceHolderText, text: $latitude)
                        .keyboardType(.decimalPad)
                        .focused($focus, equals: .lat)
                        .onChange(of: latitude) {
                            latitude = latitude.replacingOccurrences(of: ",", with: ".")
                        }
                    TextField(Constant.longitudeTextFieldPlaceHolderText, text: $longitude)
                        .keyboardType(.decimalPad)
                        .focused($focus, equals: .lon)
                        .onChange(of: longitude) {
                            longitude = longitude.replacingOccurrences(of: ",", with: ".")
                        }
                }
            }
            .navigationTitle(Constant.navigationBarTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Constant.saveButtonTitle) {
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(!isInputValid)
                }

                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(Constant.doneButtonTitle) {
                        focus = nil
                    }
                }
            }
            .onAppear { focus = .name }
        }
    }
}

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

// MARK: - Validation
private extension AddLocationSheetView {
    var isInputValid: Bool {
        Double(latitude) != nil && Double(longitude) != nil
    }
}
