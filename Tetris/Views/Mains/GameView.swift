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
            Color.white.opacity(vm.isAnimatingBackground ? 1 : 0)
                .ignoresSafeArea()
            GeometryReader { geo in
                VStack(spacing: 10) {
                    InfoGame
                    TimerTextView(tetrisMode: vm.tetrisMode, chrono: vm.chrono)
                    HStack(spacing: 0) {
                        
                        TetrisBoardView(width: geo.size.width, height: geo.size.height, squares: vm.tetris.squares, piece: vm.piece, previsualisationPiece: vm.previsualisationPiece)
                        
                        InfoSquareView(isPresenting: $vm.isAlertShowing, piece: vm.nextPiece, width: geo.size.width * 0.2, height: geo.size.height, cancelTimer: vm.resetTimer, cancelChronoTimer: vm.resetChronoTimer)
                    }
                    ControlsView(movingLeft: vm.movePieceLeft, movingRight: vm.movePieceRight, speedUp: vm.speedUpTimer, rotatePiece: vm.rotatePiece, cancellables: vm.cancellables, width: geo.size.width, height: geo.size.height * 0.2)
                }
            }
            .padding()
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
        vm.piece.color
            .ignoresSafeArea()
    }
    var InfoGame: some View {
        InfoGameView(level: vm.tetris.level, score: vm.tetris.score, lines: vm.tetris.lines)
    }
    var Alert: some View {
        CustomAlertView(isPresenting: $vm.isAlertShowing, score: vm.tetris.score, isGameLost: vm.isGameLost(), isTimedOut: vm.isTimedOut(), startTimer: vm.startTimer, startChronoTimer: vm.startChronoTimer, newGame: vm.startNewGame)
    }
    var Countdown: some View {
        CountdownView(countdown: vm.countdown)
    }
}
