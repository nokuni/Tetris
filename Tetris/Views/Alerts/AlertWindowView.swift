//
//  AlertWindowView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct AlertWindowView: View {
    @Binding var isPresenting: Bool
    var score: Int
    var isGameLost: Bool
    var isTimedOut: Bool
    var dismissAlert: (() -> Void)?
    var goBack: (() -> Void)?
    var startTimer: (() -> Void)?
    var startChronoTimer: (() -> Void)?
    var newGame: (() -> Void)?
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.black, lineWidth: 5)
                .frame(maxWidth: .infinity, maxHeight: 250)
                .background(
                    Color.theme.background
                )
            VStack(spacing: 20) {
                if isGameLost || isTimedOut {
                    Text("Score: \(score)")
                        .foregroundColor(.theme.accent)
                } else {
                    AlertChoiceButtonView(text: "CONTINUE", backgroundColor: .yellow, action: dismissAlert, secondAction: startTimer, thirdAction: startChronoTimer)
                }
                AlertChoiceButtonView(text: "NEW GAME", backgroundColor: .theme.accent, action: dismissAlert, secondAction: newGame)
                AlertChoiceButtonView(text: "QUIT", backgroundColor: .coral, action: goBack)
            }
            .font(.system(size: 20, weight: .heavy, design: .rounded))
            .foregroundColor(.theme.accent)
            .padding()
        }
        .padding()
    }
}

struct AlertWindowView_Previews: PreviewProvider {
    static var previews: some View {
        AlertWindowView(isPresenting: .constant(false), score: 0, isGameLost: true, isTimedOut: false)
    }
}
