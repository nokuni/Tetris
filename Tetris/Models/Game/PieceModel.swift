//
//  PieceModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI

struct Piece: Equatable {
    let name: String
    let image: String
    let color: Color
    var position: [Int]
    var orientation: PieceOrientation
    var pattern: [[Int]]
}

extension Piece {
    static let iBlock = Piece(name: "I Block", image: "blockI", color: .aqua, position: [23, 24, 25, 26], orientation: .top, pattern: [[-18, -9, 0, 9], [28, 19, 10, 1], [-29, -20, -11, -2], [19, 10, 1, -8]])
    static let jBlock = Piece(name: "J Block", image: "blockJ", color: .blue, position: [4, 14, 15, 16], orientation: .top, pattern: [[1, -8, 0, 9], [9, 9, 1, 1], [-9, 0, 8, -1], [-1, -1, -9, -9]])
    static let lBlock = Piece(name: "L Block", image: "blockL", color: .orange, position: [5, 13, 14, 15], orientation: .top, pattern: [[-1, 1, 10, 10], [9, 0, -9, -2], [-10, -10, -1, 1], [2, 9, 0, -9]])
    static let oBlock = Piece(name: "O Block", image: "blockO", color: .yellow, position: [14, 15, 24, 25], orientation: .top, pattern: [[Int]](repeating: [Int](repeating: 0, count: 4), count: 4))
    static let sBlock = Piece(name: "S Block", image: "blockS", color: .green, position: [5, 6, 14, 15], orientation: .top, pattern: [[0, 9, 2, 11], [10, 1, 8, -1], [-11, -2, -9, 0], [1, -8, -1, -10]])
    static let tBlock = Piece(name: "T Block", image: "blockT", color: .purple, position: [5, 14, 15, 16], orientation: .top, pattern: [[0, 1, 1, 9], [9, 0, 0, 0], [-9, -1, -1, 0], [0, 0, 0, -9]])
    static let zBlock = Piece(name: "Z Block", image: "blockZ", color: .red, position: [3, 4, 14, 15], orientation: .top, pattern: [[2, 10, 1, 9], [8, 0, 9, 1], [-9, -1, -10, -2], [-1, -9, 0, -8]])
    
    static let pieces = [iBlock, jBlock, lBlock, oBlock, sBlock, tBlock, zBlock]
}
