//
//  RotateButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI
import Combine

struct RotateButtonView: View {
    var rotatePiece: (() -> Void)?
    var cancellables: Set<AnyCancellable>
    var body: some View {
        Button(action: {
            rotatePiece?()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.black)
                Text("R")
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.system(.largeTitle, design: .monospaced))
            }
            .scaledToFit()
        }
        .disabled(cancellables.isEmpty)
    }
}

struct RotateButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RotateButtonView(cancellables: [])
    }
}
