//
//  SquareView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/10/2021.
//

import SwiftUI

struct SquareView: View {
    var index: Int
    var piece: Piece
    var previsualisationPiece: Piece
    var squares: [Color]
    var width: CGFloat
    var height: CGFloat
    var randomColor: Color {
        return Color.rainbow.randomElement()!
    }
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(index > 29 && piece.position.contains(index) || squares[index] != .clear ? Color.black : Color.clear, lineWidth: 2)
                .frame(maxWidth: width * 0.7, maxHeight: height)
                .background(
                    index < 30 ? piece.color : piece.position.contains(index) ? piece.color : squares[index]
                )
                .background(
                    previsualisationPiece.position.contains(index) ? Color.black.opacity(0.3) : Color.clear
                )
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 0, piece: Piece.jBlock, previsualisationPiece: Piece.jBlock, squares: [Color](repeating: .black, count: 100), width: 100, height: 100)
    }
}
