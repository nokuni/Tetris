//
//  HighscoreModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import SwiftUI

struct HighscoreModel: Hashable {
    let mode: TetrisMode
    var score: ScoreModel
}
