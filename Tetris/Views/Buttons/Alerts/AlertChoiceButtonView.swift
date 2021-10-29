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
    var action: (() -> Void)?
    var secondAction: (() -> Void)?
    var thirdAction: (() -> Void)?
    var body: some View {
        Button(action: {
            action?()
            secondAction?()
            thirdAction?()
        }) {
            Text(text)
                .foregroundColor(.theme.background)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.black, lineWidth: 5)
                        .background(backgroundColor)
                )
        }
    }
}

struct AlertChoiceButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AlertChoiceButtonView(text: "CONTINUE", backgroundColor: .yellow)
    }
}
