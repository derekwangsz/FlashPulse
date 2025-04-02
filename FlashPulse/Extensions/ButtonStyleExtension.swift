//
//  ButtonStyleExtension.swift
//  FlashPulse
//
//  Created by Derek Wang on 2025-04-02.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.primary)
            .padding(.horizontal, 60)
            .padding(.vertical)
            .background(.thinMaterial)
            .clipShape(Capsule())
            .shadow(radius: 2, x: 3, y: 7)
            .padding(.bottom, 50)
            .padding(.top, 10)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
            .bold()
            .foregroundStyle(.white)
            .background(Color.accentColor)
            .clipShape(Capsule(style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.smooth, value: configuration.isPressed)
    }
}



extension ButtonStyle where Self == PrimaryButtonStyle {
    static var myAppPrimaryButton: PrimaryButtonStyle { .init() }
    static var myAppSecondaryButton: SecondaryButtonStyle { .init() }
}


