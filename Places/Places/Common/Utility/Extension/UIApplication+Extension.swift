//
//  UIApplication+Extension.swift
//  Places
//
//  Created by BURAKHAN OZAY on 9.02.2026.
//

import Foundation
import SwiftUI

extension UIApplication {

    static func openURL(
        _ url: URL,
        success: (() -> Void)? = nil,
        failure: (() -> Void)? = nil
    ) {
        if canOpenURL(url) {
            UIApplication.shared.open(url)
            success?()
        } else {
            failure?()
        }
    }

    static func canOpenURL(_ url: URL) -> Bool {
        UIApplication.shared.canOpenURL(url)
    }
}
