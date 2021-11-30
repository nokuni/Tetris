//
//  AlertWindowView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct AlertWindowView: View {
    @Binding var isPresenting: Bool
    var tetris: TetrisModel
    var dismissAlert: (() -> Void)?
    var goBack: (() -> Void)?
    var resumeGame: (() -> Void)?
    var resumeChrono: (() -> Void)?
    var startNewGame: ((Adventure) -> Void)?
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(
                    Color.theme.background
                )
                .frame(maxWidth: .infinity, maxHeight: 250)
                .shadow(color: .black, radius: 0, x: 3, y: 3)
            VStack(spacing: 20) {
                if tetris.isGameLost || tetris.isTimedOut {
                    Text("Score: \(tetris.score.points)")
                        .foregroundColor(.theme.accent)
                } else {
                    AlertChoiceButtonView(text: "CONTINUE", backgroundColor: .blue, tetris: tetris, action: dismissAlert, secondAction: resumeGame, thirdAction: resumeChrono)
                }
                AlertChoiceButtonView(text: "NEW GAME", backgroundColor: .theme.accent, tetris: tetris, action: dismissAlert, fourthAction: startNewGame)
                AlertChoiceButtonView(text: "QUIT", backgroundColor: .coral, tetris: tetris, action: goBack)
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
        AlertWindowView(isPresenting: .constant(false), tetris: TetrisModel.byDefault)
    }
}
