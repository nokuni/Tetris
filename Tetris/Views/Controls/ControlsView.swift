//
//  ControlsView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI
import Combine

struct ControlsView: View {
    var movingLeft: (() -> Void)?
    var movingRight: (() -> Void)?
    var speedUp: (() -> Void)?
    var rotatePiece: (() -> Void)?
    var cancellables: Set<AnyCancellable>
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack {
            DirectionalPadView(movingLeft: movingLeft, movingRight: movingRight, speedUp: speedUp, cancellables: cancellables)
            Spacer()
            RotateButtonView(rotatePiece: rotatePiece, cancellables: cancellables)
        }
        .frame(maxWidth: width, maxHeight: height)
        .padding(.horizontal)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(cancellables: [], width: 300, height: 150)
    }
}
