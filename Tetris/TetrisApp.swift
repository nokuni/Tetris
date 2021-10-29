//
//  TetrisApp.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 01/10/2021.
//

import SwiftUI

@main
struct TetrisApp: App {
    @StateObject var vm = TetrisViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(vm)
        }
    }
}
