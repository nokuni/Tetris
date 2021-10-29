//
//  InfoSquareView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 23/10/2021.
//

import SwiftUI

struct InfoSquareView: View {
    @Binding var isPresenting: Bool
    var piece: Piece
    var width: CGFloat
    var height: CGFloat
    var cancelTimer: (() -> Void)?
    var cancelChronoTimer: (() -> Void)?
    var body: some View {
        ZStack {
            PiecePreview(piece: piece, width: width, height: height)

            PauseButtonView(isPresenting: $isPresenting, cancelTimer: cancelTimer, cancelChronoTimer: cancelChronoTimer, width: width, height: height)

        }
        .frame(maxWidth: width, maxHeight: height, alignment: .top)
        .background(Color.black)
    }
}

struct InfoSquareView_Previews: PreviewProvider {
    static var previews: some View {
        InfoSquareView(isPresenting: .constant(false), piece: Piece.iBlock, width: 100, height: 100)
    }
}
