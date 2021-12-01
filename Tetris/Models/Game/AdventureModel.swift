//
//  AdventureModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import Foundation

struct Adventure: Hashable {
    var image: String
    var title: String
    var message: String
    var lineCondition: Int?
    var mode: TetrisMode
    var chrono: ChronoModel?
}

extension Adventure {
    static let classic = Adventure(image: "cube.fill", title: "Classic", message: "The time is limited.", lineCondition: nil, mode: .classic)
    static let marathon = Adventure(image: "infinity", title: "Marathon", message: "There is nothing to limit you.", lineCondition: nil, mode: .marathon)
    static let zeroGravity = Adventure(image: "cube.transparent", title: "Zero gravity", message: "The blocks don't fall after clearing a line.", lineCondition: 5, mode: .space)
    static let intruder = Adventure(image: "cube.transparent", title: "The Intruder", message: "Sometimes, an unknown block will appear", lineCondition: 5, mode: .space)
    
    static let mains = [classic, marathon]
    static let specials = [zeroGravity]
}
