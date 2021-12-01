//
//  BoardOverlayView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 30/11/2021.
//

import SwiftUI

struct BoardOverlayView: View {
    @ObservedObject var vm: TetrisViewModel
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack {
            TimerTextView(chrono: vm.tetris.adventure?.chrono)
            PiecePreview(piece: vm.tetris.nextPiece, width: width * 0.1, height: width * 0.1)
            PauseButtonView(isPresenting: $vm.isAlertShowing, cancelTimer: vm.pauseGame, cancelChronoTimer: vm.pauseChrono, width: width * 0.1, height: width * 0.1)
        }
        .frame(width: width * 0.8, height: height * 0.7, alignment: .top)
    }
}

struct BoardOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        BoardOverlayView(vm: TetrisViewModel(), width: 100, height: 100)
    }
}
