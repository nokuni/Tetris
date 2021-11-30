//
//  AdventureAlertWindowsView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import SwiftUI

struct AdventureAlertWindowsView: View {
    @Binding var isPresenting: Bool
    var tetris: TetrisModel
    var resumeCountdown: (() -> Void)?
    var dismissAlert: (() -> Void)?
    var body: some View {
        if let adventure = tetris.adventure {
            ZStack {
                Rectangle()
                    .foregroundColor(
                        Color.theme.background
                    )
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .shadow(color: .black, radius: 0, x: 3, y: 3)
                VStack(spacing: 20) {
                    Text(adventure.message)
                    if let lineCondition = adventure.lineCondition {
                        Text("Win condition: \(lineCondition) lines")
                    } else {
                        Text("No win condition.")
                    }
                    AlertChoiceButtonView(text: "Start", backgroundColor: .black, tetris: tetris, action: resumeCountdown, secondAction: dismissAlert)
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
        AdventureAlertWindowsView(isPresenting: .constant(false), tetris: TetrisModel.byDefault)
    }
}
