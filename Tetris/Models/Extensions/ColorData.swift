//
//  ColorData.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI

extension Color {
    static let leadBlack = Color(red: 0.130, green: 0.130, blue: 0.130)
    static let skyBlue = Color(red: 135/255, green: 206/255, blue: 235/255)
    static let aqua = Color(red: 0/255, green: 255/255, blue: 255/255)
    static let midnightBlue = Color(red: 25/255, green: 25/255, blue: 112/255)
    static let aliceBlue = Color(red: 240/255, green: 248/255, blue: 255/255)
    static let darkBlue = Color(red: 0/255, green: 0/255, blue: 139/255)
    static let darkSlateBlue = Color(red: 72/255, green: 61/255, blue: 139/255)
    static let powderBlue = Color(red: 176/255, green: 224/255, blue: 230/255)
    static let olive = Color(red: 128/255, green: 128/255, blue: 0/255)
    static let mediumSeaGreen = Color(red: 60/255, green: 179/255, blue: 113/255)
    static let greenYellow = Color(red: 173/255, green: 255/255, blue: 47/255)
    static let coral = Color(red: 255/255, green: 127/255, blue: 80/255)
    static let khaki = Color(red: 240/255, green: 230/255, blue: 140/255)
    
    static let rainbow: [Color] = [.leadBlack, .skyBlue, .aqua, .midnightBlue, .aliceBlue, .darkBlue, .darkSlateBlue, .powderBlue, .olive, .mediumSeaGreen, .greenYellow, .coral, .khaki ]
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
}
