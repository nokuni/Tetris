//
//  Styles.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import SwiftUI

struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label.scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    var pressEffectStyle: some View {
        buttonStyle(PressEffectButtonStyle())
    }
}
