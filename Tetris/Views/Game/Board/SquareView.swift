//
//  SquareView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/10/2021.
//

import SwiftUI

struct SquareView: View {
    var index: Int
    var tetris: TetrisModel
    var width: CGFloat
    var height: CGFloat
    var randomColor: Color { Color.rainbow.randomElement()! }
    var spawnIndexLimit: Int { 30 }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.clear)
                //.stroke(index > 29 && tetris.piece.position.contains(index) || tetris.squares[index] != .clear ? Color.black : Color.clear, lineWidth: 1)
                .frame(maxWidth: width * 0.8, maxHeight: width * 0.8)
                .background(
                    index < spawnIndexLimit ? tetris.piece.color : tetris.piece.position.contains(index) ? tetris.piece.color : tetris.squares[index]
                )
                .background(
                    tetris.previsualisationPiece.position.contains(index) ? Color.black.opacity(0.2) : Color.clear
                )
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 0, tetris: TetrisModel.byDefault, width: 100, height: 100)
    }
}
