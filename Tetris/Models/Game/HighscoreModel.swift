//
//  HighscoreModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import SwiftUI

struct HighscoreModel: Hashable {
    let name: String
    var score: Int
}

//@Published private(set) var highscores: [HighscoreModel] = [HighscoreModel(icon: "crown.fill", color: .yellow, score: 100_000), HighscoreModel(icon: "crown.fill", color: .gray, score: 50_000), HighscoreModel(icon: "crown.fill", color: .orange, score: 10_000)].sorted(by: { $0.score > $1.score })
