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
    var tetris: TetrisModel
    var mode: TetrisMode?
    var chrono: ChronoModel
    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(tetris.squares.indices).separate(into: 10), id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(row, id: \.self) { index in
                        SquareView(index: index, tetris: tetris, width: width * 0.8, height: width * 0.8)
                    }
                }
            }
        }
        .background(Color.white)
    }
}

struct TetrisBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TetrisBoardView(width: 40, height: 100, tetris: TetrisModel.byDefault, mode: TetrisMode.classic, chrono: ChronoModel(minute: 3, second: 0))
    }
}
