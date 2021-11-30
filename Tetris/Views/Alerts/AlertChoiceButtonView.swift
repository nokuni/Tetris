//
//  AlertChoiceButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct AlertChoiceButtonView: View {
    var text: String
    var backgroundColor: Color
    var tetris: TetrisModel
    var action: (() -> Void)?
    var secondAction: (() -> Void)?
    var thirdAction: (() -> Void)?
    var fourthAction: ((Adventure) -> Void)?
    var body: some View {
        Button(action: {
            action?()
            secondAction?()
            thirdAction?()
            if let adventure = tetris.adventure { fourthAction?(adventure) }
        }) {
            Text(text)
                .foregroundColor(.theme.background)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
        }
    }
}

struct AlertChoiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AlertChoiceButtonView(text: "CONTINUE", backgroundColor: .blue, tetris: TetrisModel.byDefault)
    }
}
