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
            ZStack {
                Color.theme.background
                    .ignoresSafeArea()
                VStack(spacing: 50) {
                    Text("TETRIS")
                        .foregroundColor(.theme.accent)
                        .font(.system(size: 90, weight: .heavy, design: .monospaced))
                        .scaledToFit()
                    NavigationLink(destination: GameView()) {
                        HomeMenuButtonView(image: "cube.fill", text: "CLASSIC", color: .aliceBlue)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            vm.setTetrisMode(mode: .classic)
                        }
                    )
                    NavigationLink(destination: GameView()) {
                        HomeMenuButtonView(image: "infinity", text: "MARATHON", color: .powderBlue)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            vm.setTetrisMode(mode: .marathon)
                        }
                    )
                    NavigationLink(destination: HighScoreView()) {
                        HomeMenuButtonView(image: "crown.fill", text: "HIGHSCORES", color: .khaki)
                    }
                    Spacer()
                }
            }
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
