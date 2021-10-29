//
//  TetrisModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 22/10/2021.
//

import SwiftUI

struct TetrisModel: Equatable {
    var score: Int
    var level: Int
    var lines: Int
    var squares: [Color]
    
    var nextLevel: Int {
        (level * 10) + 10
    }
}

extension TetrisModel {
    static let byDefault = TetrisModel(score: 0, level: 0, lines: 0, squares: [Color](repeating: .clear, count: 230))
}

enum TetrisMode {
    case classic
    case marathon
}
