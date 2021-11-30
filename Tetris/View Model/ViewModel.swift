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
    @Published private(set) var highscores: [HighscoreModel] = [].sorted(by: { $0.score.points > $1.score.points })
    
    var gameTimer: Timer?
    var chronoTimer: Timer?
    var countdownTimer: Timer?
    
    @Published var isAlertShowing = false
    @Published var isAdventureAlertShowing = false
    @Published var isAnimatingBackground = false
    @Published var isAnimatingText = false
    
    @Published private(set) var countdown = 3
    
    // MARK: - Board Timer
    
    func resumeGame() {
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(withTimeInterval: tetris.score.speed, repeats: true, block: gameOnGoing)
    }
    func pauseGame() { gameTimer?.invalidate() }
    func gameOnGoing(timer: Timer) {
        if !tetris.isPieceOnLastRow(piece: tetris.piece) && !tetris.isPieceCollidingBottom(piece: tetris.piece) {
            movePieceDown()
        } else {
            drawPieceOnBoard()
            checkFullColoredRows()
            generateRandomNewPiece()
            generateNextRandomNewPiece()
            getPrevisualisationPiece()
            if tetris.isGameLost { endGame() }
            if tetris.isGameWon(adventure: tetris.adventure) { endGame() }
        }
    }
    
    // MARK: - Chrono Timer
    
    // Chrono
    func resumeChrono() {
        chronoTimer?.invalidate()
        chronoTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: chronoOnGoing)
    }
    func pauseChrono() { chronoTimer?.invalidate() }
    func chronoOnGoing(timer: Timer) {
        guard let adventure = tetris.adventure else { return }
        guard let chrono = adventure.chrono else { return }
        switch true {
        case chrono.second > 0:
            tetris.adventure?.chrono?.second -= 1
        case chrono.minute > 0:
            tetris.adventure?.chrono?.minute -= 1
            tetris.adventure?.chrono?.second += 59
        default:
            endGame()
        }
    }
    
    // MARK: - Countdown Timer
    
    func resumeCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: countdownOnGoing)
    }
    func pauseCountdown() { countdownTimer?.invalidate() }
    func countdownOnGoing(timer: Timer) {
        guard let adventure = tetris.adventure else { return }
        if countdown > 0 { countdown -= 1 } else {
            countdown -= 1
            pauseCountdown()
            resumeGame()
            resumeChrono()
            if adventure.mode == .classic { resumeChrono() }
        }
    }
    
    // MARK: - Game Conditions
    
    // Create a new game.
    func startNewGame(adventure: Adventure) {
        print("You started a new game!")
        tetris = TetrisModel.byDefault
        tetris.adventure = adventure
        isAdventureAlertShowing.toggle()
        tetris.piece = Piece.pieces.randomElement()!
        tetris.nextPiece = Piece.pieces.randomElement()!
        tetris.previsualisationPiece = tetris.piece
        if adventure.mode == .classic { tetris.adventure?.chrono = ChronoModel(minute: 3, second: 0) }
        countdown = 3
        getPrevisualisationPiece()
    }
    
    // End Game
    func endGame() {
        pauseGame()
        pauseChrono()
        highscores.append(HighscoreModel(mode: tetris.adventure!.mode, score: tetris.score))
        isAlertShowing.toggle()
    }
    
    // Draw the dropping piece into colored squares on the board.
    func drawPieceOnBoard() {
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
    
    // Previsualisation of the dropping piece.
    func getPrevisualisationPiece() {
        tetris.previsualisationPiece = tetris.piece
        repeat {
            tetris.previsualisationPiece.position.indices.forEach { tetris.previsualisationPiece.position[$0] += tetris.columnsIndices.count }
        } while !tetris.isPieceOnLastRow(piece: tetris.previsualisationPiece) && !tetris.isPieceCollidingBottom(piece: tetris.previsualisationPiece)
    }
    
    // Level Up
    func LevelUp() {
        tetris.score.level = tetris.score.lines > tetris.score.nextLevel ? tetris.score.level + 1 : tetris.score.level + 0
    }
    
    // Rotate the dropping piece with an orientation
    func orientPiece(index: Int, orientation: PieceOrientation) {
        let indices = tetris.piece.position.indices
        // Check if the new position of the piece is all clear
        let isAllClear = indices.allSatisfy({ tetris.isSquareClear(index: tetris.piece.position[$0] + tetris.piece.pattern[index][$0]) })
        if isAllClear {
            tetris.piece.position.indices.forEach { tetris.piece.position[$0] += tetris.piece.pattern[index][$0] }
            tetris.piece.orientation = orientation
        }
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
        if !tetris.isPieceOnRightEdge && !tetris.isPieceCollidingHorizontally(by: [-1]) {
            tetris.piece.position = nextPositon
            if !tetris.isPieceOnLastRow(piece: tetris.piece) { getPrevisualisationPiece() }
        }
    }
    
    // Move the dropping piece on the left
    func movePieceLeft() {
        let nextPositon = tetris.piece.position.map { $0 - 1 }
        guard tetris.boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !tetris.isPieceOnLeftEdge && !tetris.isPieceCollidingHorizontally(by: [1]) {
            tetris.piece.position = nextPositon
            if !tetris.isPieceOnLastRow(piece: tetris.piece) { getPrevisualisationPiece() }
        }
    }
    
    // Move the dropping piece one square down
    func movePieceDown() {
        let nextPositon = tetris.piece.position.map { $0 + 10 }
        guard tetris.boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !tetris.isPieceCollidingBottom(piece: tetris.piece) && !tetris.isPieceOnLastRow(piece: tetris.piece) {
            tetris.piece.position = nextPositon
        }
    }
    
    // MARK: - Board passive actions
    
    // Check the scoring
    func scoringPoints(lineCleared: Int) {
        switch lineCleared {
        case 1:
            tetris.score.points += tetris.score.linePoints[lineCleared - 1]
        case 2:
            tetris.score.points += tetris.score.linePoints[lineCleared - 1]
        case 3:
            tetris.score.points += tetris.score.linePoints[lineCleared - 1]
        case 4:
            tetris.score.points += tetris.score.linePoints[lineCleared - 1]
        default:
            tetris.score.points += 0
        }
    }
    
    // Clear a full colored squares row
    func clearLine(rowIndex: [Int]) {
        if let firstLineIndex = rowIndex.first,
           let lastLineIndex = rowIndex.last {
            withAnimation {
                tetris.squares.replaceSubrange(firstLineIndex ... lastLineIndex, with: [Color](repeating: .clear, count: rowIndex.count))
                tetris.score.lines += 1
            }
        }
    }
    
    // Check if all the rows on the board are full colored squares, clear them and make the squares fall.
    func checkFullColoredRows() {
        var lineCleared = 0
        repeat {
            for rowIndex in Array(tetris.rowsIndices.reversed()) {
                if tetris.isRowFullColored(row: rowIndex) {
                    lineCleared += 1
                    clearLine(rowIndex: rowIndex)
                    if tetris.adventure?.mode != .space { bringDownBlocks() }
                    animateBackground()
                }
            }
        } while Array(tetris.rowsIndices.reversed()).contains(where: { tetris.isRowFullColored(row: $0) })
        
        if lineCleared >= 4 {
            withAnimation(.linear(duration: 0.1).repeatForever()) {
                isAnimatingText.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.isAnimatingText.toggle()
                }
            }
        }
        scoringPoints(lineCleared: lineCleared)
        LevelUp()
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
        
    }
}
