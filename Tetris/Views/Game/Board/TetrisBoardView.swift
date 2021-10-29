//
//  TetrisBoardView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI

struct TetrisBoardView: View {
    var width: CGFloat
    var height: CGFloat
    var squares: [Color]
    var piece: Piece
    var previsualisationPiece: Piece
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(squares.indices).separate(into: 10), id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { index in
                        SquareView(index: index, piece: piece, previsualisationPiece: previsualisationPiece, squares: squares, width: width, height: height)
                    }
                }
            }
        }
        .padding(5)
        .background(Color.white)
        .border(Color.black, width: 5)
    }
}

struct TetrisBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisBoardView(width: 100, height: 100, squares: [], piece: Piece.iBlock, previsualisationPiece: Piece.jBlock)
    }
}
