//
//  AccessibilityHint.swift
//  Places
//
//  Created by BURAKHAN OZAY on 9.02.2026.
//


enum AccessibilityHint: String {
    // MARK: - LocationsRowView
    case openWikipedia = "Opens Wikipedia app on the Places tab for these coordinates."

    // MARK: - LocationsView
    case empty = "Use Add Location button to create a new one."
    case error = "Try again later."
    case addLocation = "Opens a form to add a custom location."

    // MARK: - AddLocationSheetView
    case nameField = "Optional. Enter a label for this location."
    case latitudeField = "Required. Must be between minus 90 and 90."
    case longitudeField = "Required. Must be between minus 180 and 180."
    case saveEnabled = "Saves this location and adds it to the list."
    case saveDisabled = "Enter valid latitude and longitude to enable Save."
    case doneButton = "Dismisses the keyboard."
}
