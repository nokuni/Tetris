//
//  ScoreModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 23/10/2021.
//

import Foundation

enum LineCleared: Int {
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    
    var text: String {
        switch self {
        case .one:
            return "LINE"
        case .two:
            return "DOUBLE"
        case .three:
            return "TRIPLE"
        case .four:
            return "LINEBLOCK"
        }
    }
}
