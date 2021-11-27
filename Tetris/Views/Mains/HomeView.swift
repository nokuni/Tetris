//
//  HomeView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 23/10/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: TetrisViewModel
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 25) {
                    NavigationLink(destination: GameView()) {
                        HomeMenuButtonView(image: "cube.fill", text: "Classic", color: .powderBlue)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            vm.setTetrisMode(mode: .classic)
                        }
                    )
                    NavigationLink(destination: GameView()) {
                        HomeMenuButtonView(image: "infinity", text: "Marathon", color: .coral)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            vm.setTetrisMode(mode: .marathon)
                        }
                    )
                    NavigationLink(destination: HighScoreView()) {
                        HomeMenuButtonView(image: "crown.fill", text: "Highscores", color: .khaki)
                    }
                }
            }
            .navigationTitle("Tetris")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TetrisViewModel())
            .preferredColorScheme(.dark)
    }
}
