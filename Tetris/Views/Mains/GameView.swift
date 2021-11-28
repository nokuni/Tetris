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
            if vm.tetrisMode == .space { SpaceBackgroundView() }
            Color.white.opacity(vm.isAnimatingBackground ? 1 : 0)
                .ignoresSafeArea()
            Board
            Alert
            Countdown
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.isAlertShowing = false
            vm.startNewGame()
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
            VStack(spacing: 10) {
                InfoGame
                TetrisBoardView(width: geo.size.width * 0.1, height: geo.size.width, tetris: vm.tetris, mode: vm.tetrisMode, chrono: vm.chrono, isShowing: $vm.isAnimatingText)
                        .overlay(
                            HStack {
                                TimerTextView(tetrisMode: vm.tetrisMode, chrono: vm.chrono)
                                PiecePreview(piece: vm.tetris.nextPiece, width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                                PauseButtonView(isPresenting: $vm.isAlertShowing, cancelTimer: vm.resetTimer, cancelChronoTimer: vm.resetChronoTimer, width: geo.size.width * 0.1, height: geo.size.width * 0.1)
                            }
                                .frame(width: geo.size.width * 0.8, height: geo.size.height * 0.7, alignment: .top)
                        )
                ControlsView(movingLeft: vm.movePieceLeft, movingRight: vm.movePieceRight, speedUp: vm.movePieceDown, rotatePiece: vm.rotatePiece, cancellables: vm.gameCancellables, width: geo.size.width, height: geo.size.height * 0.15)
            }
        }
        .padding()
    }
    var Alert: some View {
        CustomAlertView(isPresenting: $vm.isAlertShowing, score: vm.tetris.score.points, isGameLost: vm.tetris.isGameLost(), isTimedOut: vm.isTimedOut(), startTimer: vm.startTimer, startChronoTimer: vm.startChronoTimer, newGame: vm.startNewGame)
    }
    var Countdown: some View {
        CountdownView(countdown: vm.countdown)
    }
}
