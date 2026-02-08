//
//  ValidatableTextField.swift
//  Places
//
//  Created by BURAKHAN OZAY on 7.02.2026.
//

import SwiftUI

struct ValidatableTextField: View {

    let model: Model

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            TextField(model.title, text: model.text)
                .keyboardType(model.keyboard)
                .focused(model.focus, equals: model.focusField)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular)
                        .stroke(model.error == nil ? Color.gray : Color.red, lineWidth: 2)
                )

            if let error = model.error {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.horizontal, 8)
            }
        }
    }
}

extension ValidatableTextField {
    struct Model {
        let title: String
        let text: Binding<String>
        let focus: FocusState<AddLocationSheetVM.AddLocationField?>.Binding
        let keyboard: UIKeyboardType
        let error: String?
        let focusField: AddLocationSheetVM.AddLocationField

        init(
            title: String,
            text: Binding<String>,
            focus: FocusState<AddLocationSheetVM.AddLocationField?>.Binding,
            keyboard: UIKeyboardType = .default,
            error: String? = nil,
            focusField: AddLocationSheetVM.AddLocationField = .name
        ) {
            self.title = title
            self.text = text
            self.focus = focus
            self.keyboard = keyboard
            self.error = error
            self.focusField = focusField
        }
    }
}
