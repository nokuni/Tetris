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
            KeyPadView(action: movingLeft, image: "arrowtriangle.backward.fill", height: height * 0.5, cancellables: cancellables)
            VStack {
                Spacer()
                KeyPadView(action: speedUp, image: "arrowtriangle.down.fill", height: height * 0.5, cancellables: cancellables)
            }
            KeyPadView(action: movingRight, image: "arrowtriangle.forward.fill", height: height * 0.5, cancellables: cancellables)
            
            ActionButtonView(image: "rotate.right.fill", action: rotatePiece, cancellables: cancellables)
        }
        .frame(maxWidth: width, maxHeight: height)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(cancellables: [], width: 300, height: 50)
    }
}
