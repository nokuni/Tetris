//
//  ControlsView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI
import Combine

struct ControlsView: View {
    @ObservedObject var vm: TetrisViewModel
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack {
            KeyPadView(action: vm.movePieceLeft, image: "arrowtriangle.backward.fill", height: height * 0.5)
            VStack {
                Spacer()
                KeyPadView(action: vm.movePieceDown, image: "arrowtriangle.down.fill", height: height * 0.5)
            }
            KeyPadView(action: vm.movePieceRight, image: "arrowtriangle.forward.fill", height: height * 0.5)
            
            ActionButtonView(image: "rotate.right.fill", action: vm.rotatePiece)
        }
        .frame(maxWidth: width, maxHeight: height)
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView(vm: TetrisViewModel(), width: 300, height: 50)
    }
}
