//
//  ColorExtension.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-03-30.
//

import Foundation
import SwiftUI

public extension Color {

    static func random() -> Color {
        Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}
