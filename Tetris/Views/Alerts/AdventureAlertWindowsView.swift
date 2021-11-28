//
//  AdventureAlertWindowsView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import SwiftUI

struct AdventureAlertWindowsView: View {
    @Binding var isPresenting: Bool
    var adventure: Adventure?
    var startCountdownTimer: (() -> Void)?
    var dismissAlert: (() -> Void)?
    var body: some View {
        if let adventure = adventure {
            ZStack {
                Rectangle()
                    .foregroundColor(
                        Color.theme.background
                    )
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .shadow(color: .black, radius: 0, x: 3, y: 3)
                VStack(spacing: 20) {
                    Text(adventure.message)
                    Text("Win condition: \(adventure.lineCondition) lines")
                    AlertChoiceButtonView(text: "Start", backgroundColor: .black, action: startCountdownTimer, secondAction: dismissAlert)
                }
                .font(.system(size: 20, weight: .heavy, design: .rounded))
                .foregroundColor(.theme.accent)
                .padding()
            }
            .padding()
        }
    }
}

struct AdventureAlertWindowsView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureAlertWindowsView(isPresenting: .constant(false), adventure: Adventure(image: "slowmo", title: "New Dimension", message: "The gravity is different here, be careful.", lineCondition: 20, mode: .space))
    }
}
