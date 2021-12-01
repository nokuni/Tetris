//
//  ContentView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 01/10/2021.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var vm: TetrisViewModel
    var body: some View {
        ZStack {
            Background
            if let adventure = vm.tetris.adventure {
                if adventure.mode == .space { SpaceBackgroundView() }
            }
            Color.white.opacity(vm.isAnimatingBackground ? 1 : 0)
                .ignoresSafeArea()
            Board
            Countdown
            Alert
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.isAlertShowing = false
            if !vm.isAdventureAlertShowing { vm.resumeCountdown() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().environmentObject(TetrisViewModel())
    }
}

extension GameView {
    var Background: some View {
        vm.tetris.piece.color
            .ignoresSafeArea()
    }
    var InfoGame: some View {
        InfoGameView(score: vm.tetris.score)
    }
    var Board: some View {
        GeometryReader { geo in
            VStack {
                InfoGame
                TetrisBoardView(width: geo.size.width * 0.1, height: geo.size.width, tetris: vm.tetris, isShowing: $vm.isAnimatingText)
                    .overlay(BoardOverlayView(vm: vm, width: geo.size.width, height: geo.size.height))
                ControlsView(vm: vm, width: geo.size.width, height: geo.size.height * 0.15)
            }
        }
        .padding()
    }
    var Alert: some View {
        CustomAlertView(vm: vm)
    }
    var Countdown: some View {
        CountdownView(countdown: vm.tetris.countdown)
    }
}
