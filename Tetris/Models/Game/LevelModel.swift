//
//  LevelModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

// Property wrapper to limit the level to 29.
@propertyWrapper
struct LevelLimit: Hashable, Equatable {
    private var level = 0
    var wrappedValue: Int {
        get { return level }
        set { level = min(newValue, 29)}
    }
}

struct ScoreModel: Hashable, Equatable {
    @LevelLimit var level: Int
    var points: Int
    var lines: Int
    var linePoints: [Int] { [40, 100, 300, 1200].map { $0 * (level + 1) } }
    var speed: Double { ScoreModel.speeds[level] }
    var nextLevel: Int { (level * 10) + 10 }
    static let speeds: [Double] = [0.48, 0.43, 0.38, 0.33, 0.28, 0.23, 0.18, 0.13, 0.08, 0.06, 0.05, 0.05, 0.05, 0.04, 0.04, 0.04, 0.03, 0.03, 0.03, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.02, 0.01]
}
