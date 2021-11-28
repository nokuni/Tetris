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
    var lineCondition: Int
    var mode: TetrisMode
}

extension Adventure {
    static let newDimension = Adventure(image: "slowmo", title: "New Dimension", message: "The gravity is different here, be careful.", lineCondition: 5, mode: .space)
    
    static let adventures = [newDimension]
}
