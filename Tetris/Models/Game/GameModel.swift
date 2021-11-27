//
//  GameModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import Foundation

struct GameModel {
    var tetris: TetrisModel
    var mode: TetrisMode?
    var highscores: [HighscoreModel]
}
