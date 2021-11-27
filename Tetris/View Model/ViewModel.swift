//
//  ViewModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 01/10/2021.
//

import Foundation
import Combine
import SwiftUI

final class TetrisViewModel: ObservableObject {
    
    @Published private(set) var tetris = TetrisModel.byDefault
    @Published private(set) var tetrisMode: TetrisMode? = nil
    
    @Published private(set) var highscores: [HighscoreModel] = [
        HighscoreModel(name: "OKI", score: 100_000),
        HighscoreModel(name: "LMP", score: 50_000),
        HighscoreModel(name: "CGF", score: 10_000)
    ].sorted(by: { $0.score > $1.score })
    @Published var isAlertShowing = false
    @Published var isAnimatingBackground = false
    
    @Published private(set) var chrono: ChronoModel = ChronoModel(minute: 3, second: 0)
    @Published private(set) var countdown = 3
    @Published private(set) var speed: Double = 0.0
    
    @Published private(set) var gameCancellables = Set<AnyCancellable>()
    @Published private(set) var chronoCancellables = Set<AnyCancellable>()
    @Published private(set) var countdownCancellables = Set<AnyCancellable>()
    
    // MARK: - Board Timer
    
    // Game speed
    func getGameSpeed() -> Double { speeds[tetris.level] }
    
    // Start a timer for the board.
    func startTimer() {
        Timer
            .publish(every: speed, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.gameOnGoing
            }
            .store(in: &gameCancellables)
    }
    
    // Manage all the behaviors the board.
    var gameOnGoing: Void {
        if !tetris.isPieceOnLastRow(piece: tetris.piece) && !tetris.isPieceCollidingBottom(piece: tetris.piece) {
            dropPiece()
        } else {
            slowDownTimer()
            createPieceOnBoard()
            checkFullColoredRows()
            generateRandomNewPiece()
            generateNextRandomNewPiece()
            getPrevisualisationPiece()
            if tetris.isGameLost() { endGame() }
        }
    }
    
    // Cancel & reset the board timer.
    func resetTimer() {
        gameCancellables.forEach { $0.cancel() }
        gameCancellables.removeAll()
    }
    
    // Speed up the timer speed.
    func speedUpTimer() {
        if speed != 0.01 {
            resetTimer()
            speed = 0.01
            startTimer()
        }
    }
    
    // Slow down the timer speed.
    func slowDownTimer() {
        resetTimer()
        speed = getGameSpeed()
        startTimer()
    }
    
    // MARK: - Chrono Timer
    
    // Start a timer for the game chrono.
    func startChronoTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.chronoOnGoing()
            }
            .store(in: &chronoCancellables)
    }
    
    // Chrono
    func chronoOnGoing() {
        switch true {
        case chrono.second > 0:
            chrono.second -= 1
        case chrono.minute > 0:
            chrono.minute -= 1
            chrono.second += 59
        default:
            endGame()
        }
    }
    
    // Cancel & reset the chrono timer.
    func resetChronoTimer() {
        chronoCancellables.forEach { $0.cancel() }
        chronoCancellables.removeAll()
    }
    
    // Check if the chrono is timed out.
    func isTimedOut() -> Bool {
        chrono.minute == 0 && chrono.second == 0 ? true : false
    }
    
    // MARK: - Countdown Timer
    
    // Start a timer for the game chrono.
    func startCountdownTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.countdownOnGoing()
            }
            .store(in: &countdownCancellables)
    }
    
    // Countdown running logic
    func countdownOnGoing() {
        if countdown > 0 { countdown -= 1 } else {
            countdown -= 1
            resetCountdownTimer()
            startTimer()
            if tetrisMode == .classic { startChronoTimer() }
        }
    }
    
    // Cancel & reset the countdown timer.
    func resetCountdownTimer() {
        countdownCancellables.forEach { $0.cancel() }
        countdownCancellables.removeAll()
    }
    
    // MARK: - Game Conditions
    
    // Create a new game.
    func startNewGame() {
        resetAllTimers()
        resetGame()
        getPrevisualisationPiece()
        startCountdownTimer()
    }
    
    // Reset the game
    func resetGame() {
        tetris = TetrisModel.byDefault
        tetris.piece = Piece.pieces.randomElement()!
        tetris.nextPiece = Piece.pieces.randomElement()!
        tetris.previsualisationPiece = tetris.piece
        chrono = ChronoModel(minute: 3, second: 0)
        countdown = 3
    }
    
    // Reset the game, chrono and countdown timer.
    func resetAllTimers() {
        resetTimer()
        resetChronoTimer()
        resetCountdownTimer()
    }
    
    // Set a tetris mode
    func setTetrisMode(mode: TetrisMode) {
        tetrisMode = mode
    }
    
    // End Game
    func endGame() {
        //highscores.append(HighscoreModel(icon: "person.fill", color: .powderBlue, score: tetris.score))
        resetAllTimers()
        isAlertShowing.toggle()
    }
    
    // Transform the dropping piece into colored squares on the board.
    func createPieceOnBoard() {
        tetris.piece.position.forEach { tetris.squares[$0] = tetris.piece.color }
    }
    
    // Generate a random new dropping piece.
    func generateRandomNewPiece() {
        switch tetris.nextPiece.name {
        case "J Block":
            tetris.piece = Piece.jBlock
        case "L Block":
            tetris.piece = Piece.lBlock
        case "O Block":
            tetris.piece = Piece.oBlock
        case "S Block":
            tetris.piece = Piece.sBlock
        case "T Block":
            tetris.piece = Piece.tBlock
        case "Z Block":
            tetris.piece = Piece.zBlock
        default:
            tetris.piece = Piece.iBlock
        }
    }
    
    // Generate next random dropping piece.
    func generateNextRandomNewPiece() {
        tetris.nextPiece = Piece.pieces.randomElement()!
    }
    
    // Move the dropping piece one square down.
    func dropPiece() {
        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += tetris.columnsIndices.count }
    }
    
    // Previsualisation of the dropping piece.
    func getPrevisualisationPiece() {
        tetris.previsualisationPiece = tetris.piece
        repeat {
            tetris.previsualisationPiece.position.indices.forEach { tetris.previsualisationPiece.position[$0] += tetris.columnsIndices.count }
        } while !tetris.isPieceOnLastRow(piece: tetris.previsualisationPiece) && !tetris.isPieceCollidingBottom(piece: tetris.previsualisationPiece)
    }
    
    // Level Up
    func LevelUp() {
        if tetris.lines > tetris.nextLevel {
            tetris.level += 1
        }
    }
    
    // Rotate the dropping piece with an orientation
    func orientPiece(index: Int, orientation: PieceOrientation) {
        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += tetris.piece.pattern[index][$0] }
        tetris.piece.orientation = orientation
    }
    
    // Rotate the dropping piece in a repeating cycle of 4 stances.
    func rotatePiece() {
        kickWallIBlock(orientation: tetris.piece.orientation)
        kickWallBlock(orientation: tetris.piece.orientation)
        switch tetris.piece.orientation {
        case .top:
            orientPiece(index: 0, orientation: .trailing)
        case .trailing:
            if !tetris.isPieceCollidingHorizontally(by: [1]) && tetris.piece.name != "I Block" {
                orientPiece(index: 1, orientation: .bottom)
            } else if !tetris.isPieceCollidingHorizontally(by: [-1, 1, 2]) {
                orientPiece(index: 1, orientation: .bottom)
            }
        case .bottom:
            orientPiece(index: 2, orientation: .leading)
        case .leading:
            if !tetris.isPieceCollidingHorizontally(by: [-1]) && tetris.piece.name != "I Block" {
                orientPiece(index: 3, orientation: .top)
            } else if !tetris.isPieceCollidingHorizontally(by: [-2, -1, 1]) {
                orientPiece(index: 3, orientation: .top)
            }
        }
        getPrevisualisationPiece()
    }
    
    // Move the dropping piece on the right
    func movePieceRight() {
        let nextPositon = tetris.piece.position.map { $0 + 1 }
        guard tetris.boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !tetris.isPieceOnRightEdge() && !tetris.isPieceCollidingHorizontally(by: [-1]) {
            tetris.piece.position = nextPositon
            getPrevisualisationPiece()
        }
    }
    
    // Move the dropping piece on the left
    func movePieceLeft() {
        let nextPositon = tetris.piece.position.map { $0 - 1 }
        guard tetris.boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !tetris.isPieceOnLeftEdge() && !tetris.isPieceCollidingHorizontally(by: [1]) {
            tetris.piece.position = nextPositon
            getPrevisualisationPiece()
        }
    }
    
    // MARK: - Board passive actions
    
    // Check the scoring
    func scoringPoints(numberOfLines: Int) {
        switch numberOfLines {
        case 1:
            tetris.score += 40
        case 2:
            tetris.score += 100
        case 3:
            tetris.score += 300
        case 4:
            tetris.score += 1200
        default:
            tetris.score += 0
        }
    }
    
    // Clear a full colored squares row
    func clearLine(rowIndex: [Int]) {
        if let firstLineIndex = rowIndex.first,
           let lastLineIndex = rowIndex.last {
            withAnimation {
                tetris.squares.replaceSubrange(firstLineIndex ... lastLineIndex, with: [Color](repeating: .clear, count: rowIndex.count))
                tetris.lines += 1
            }
        }
    }
    
    // Check if all the rows on the board are full colored squares, clear them and make the squares fall.
    func checkFullColoredRows() {
        repeat {
            var lineCounter = 0
            for rowIndex in Array(tetris.rowsIndices.reversed()) {
                if tetris.isRowFullColored(row: rowIndex) {
                    lineCounter += 1
                    clearLine(rowIndex: rowIndex)
                    //DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { self.bringDownBlocks() }
                    bringDownBlocks()
                    animateBackground()
                }
            }
            scoringPoints(numberOfLines: lineCounter)
            LevelUp()
        } while Array(tetris.rowsIndices.reversed()).contains(where: { tetris.isRowFullColored(row: $0) })
    }
    
    func animateBackground() {
        withAnimation(.linear(duration: 0.1).repeatCount(6)) {
            isAnimatingBackground.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.isAnimatingBackground.toggle()
            }
        }
    }
    
    // Drop all the colored squares one square down.
    func bringDownBlocks() {
        let colorsIndices = tetris.squares.indices.filter { tetris.squares[$0] != .clear }
        for index in colorsIndices.reversed() {
            if tetris.isSquareCanDrop(index: index) {
                tetris.squares[tetris.getNextBottomSquareIndex(index: index)] = tetris.squares[index]
                tetris.squares[index] = .clear
            }
        }
        
    }
    
    // MARK: - Kick Wall
    // Kick wall is the expression use to allow the dropping piece to rotate on the edge of the tetris board. It will simply push the piece in a given direction and give enough space to rotate.
    
    // Manage the kick wall for I Block (This one has a special kickwall)
    func kickWallIBlock(orientation: PieceOrientation) {
        let trailingKickWall : [(Int, Int)] = [(0,2), (1,1), (9,-1)]
        let leadingKickWall : [(Int, Int)] = [(0,1), (8,-1), (9,-2)]
        
        if tetris.piece.name == "I Block" {
            switch orientation {
            case .top:
                if tetris.isPieceOnLastRow(piece: tetris.piece) || tetris.isPieceCollidingBottom(piece: tetris.piece) {
                    tetris.piece.position.indices.forEach { tetris.piece.position[$0] -= tetris.columnsIndices.count }
                }
            case .trailing:
                trailingKickWall.forEach { (index, value) in
                    if tetris.columnsIndices[index].contains(where: { tetris.piece.position.contains($0) }) {
                        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += value }
                    }
                }
            case .bottom:
                tetris.piece.position.indices.forEach { tetris.piece.position[$0] += 0 }
            case .leading:
                leadingKickWall.forEach { (index, value) in
                    if tetris.columnsIndices[index].contains(where: { tetris.piece.position.contains($0) }) {
                        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += value }
                    }
                }
            }
        }
    }
    
    // Manage the kick wall for others pieces
    func kickWallBlock(orientation: PieceOrientation) {
        let piecesNames = ["J Block", "L Block", "O Block", "S Block", "T Block", "Z Block"]
        let trailingKickWall : [(Int, Int)] = [(0,1)]
        let leadingKickWall : [(Int, Int)] = [(9,-1)]
        
        if piecesNames.contains(tetris.piece.name) {
            switch orientation {
            case .top:
                if tetris.isPieceOnLastRow(piece: tetris.piece) {
                    tetris.piece.position.indices.forEach { tetris.piece.position[$0] -= tetris.columnsIndices.count }
                }
            case .trailing:
                trailingKickWall.forEach { (index, value) in
                    if tetris.columnsIndices[index].contains(where: { tetris.piece.position.contains($0) }) {
                        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += value }
                    }
                }
            case .bottom:
                tetris.piece.position.indices.forEach { tetris.piece.position[$0] += 0 }
            case .leading:
                leadingKickWall.forEach { (index, value) in
                    if tetris.columnsIndices[index].contains(where: { tetris.piece.position.contains($0) }) {
                        tetris.piece.position.indices.forEach { tetris.piece.position[$0] += value }
                    }
                }
            }
        }
    }
    
    init() {
        speed = getGameSpeed()
    }
}
