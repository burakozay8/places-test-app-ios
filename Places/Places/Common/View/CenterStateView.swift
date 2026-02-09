//
//  CenterStateView.swift
//  Places
//
//  Created by BURAKHAN OZAY on 9.02.2026.
//

import SwiftUI

struct CenterStateView: View {

    let model: Model

    var body: some View {
        Text(model.title)
            .font(.title2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityLabel(model.accessibilityLabel.rawValue)
            .accessibilityHint(model.accessibilityHint?.rawValue ?? "")
    }
}

extension CenterStateView {
    struct Model {
        let title: String
        let accessibilityLabel: AccessibilityLabel
        let accessibilityHint: AccessibilityHint?
    }
}
