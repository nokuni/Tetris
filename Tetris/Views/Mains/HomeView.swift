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
                    AdventureButton
                    ClassicButton
                    MarathonButton
                    HighscoresButton
                }
            }
            .navigationTitle("LineBlock")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(TetrisViewModel())
            .preferredColorScheme(.light)
    }
}

extension HomeView {
    var AdventureButton: some View {
        NavigationLink(destination: AdventureView(vm: vm)) {
            HomeMenuButtonView(image: "book.fill", text: "Adventure", color: .aliceBlue)
        }
    }
    var ClassicButton: some View {
        NavigationLink(destination: GameView()) {
            HomeMenuButtonView(image: Adventure.classic.image, text: Adventure.classic.title, color: .powderBlue)
        }
        .simultaneousGesture(
            TapGesture().onEnded { _ in
                vm.startNewGame(adventure: .classic)
            }
        )
    }
    var MarathonButton: some View {
        NavigationLink(destination: GameView()) {
            HomeMenuButtonView(image: Adventure.marathon.image, text: Adventure.marathon.title, color: .coral)
        }
        .simultaneousGesture(
            TapGesture().onEnded { _ in
                vm.startNewGame(adventure: .marathon)
            }
        )
    }
    var HighscoresButton: some View {
        NavigationLink(destination: HighScoreView(vm: vm)) {
            HomeMenuButtonView(image: "crown.fill", text: "Highscores", color: .khaki)
        }
    }
}
