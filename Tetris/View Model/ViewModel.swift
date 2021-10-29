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
    @Published private(set) var piece: Piece = Piece.pieces.randomElement()!
    @Published private(set) var nextPiece = Piece.pieces.randomElement()!
    @Published private(set) var previsualisationPiece = Piece.iBlock
    
    @Published private(set) var highscores: [HighscoreModel] = [HighscoreModel(icon: "crown.fill", color: .yellow, score: 100_000), HighscoreModel(icon: "crown.fill", color: .gray, score: 50_000), HighscoreModel(icon: "crown.fill", color: .orange, score: 10_000)].sorted(by: { $0.score > $1.score })
    @Published var isAlertShowing = false
    @Published var isAnimatingBackground = false
    
    @Published private(set) var chrono: ChronoModel = ChronoModel(minute: 3, second: 0)
    @Published private(set) var countdown = 3
    @Published private(set) var speed: Double = 0.0
    
    @Published private(set) var cancellables = Set<AnyCancellable>()
    @Published private(set) var chronoCancellables = Set<AnyCancellable>()
    @Published private(set) var countdownCancellables = Set<AnyCancellable>()
    
    // MARK: - Board Timer
    
    // Game speed
    func getGameSpeed() -> Double {
        return speeds[tetris.level]
    }
    
    // Start a timer for the board.
    func startTimer() {
        Timer
            .publish(every: speed, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.gameOnGoing
            }
            .store(in: &cancellables)
    }
    
    // Manage all the behaviors the board.
    var gameOnGoing: Void {
        if !isPieceOnLastRow(piece: piece) && !isPieceCollidingBottom(piece: piece) {
            dropPiece()
        } else {
            slowDownTimer()
            createPieceOnBoard()
            checkFullColoredRows()
            generateRandomNewPiece()
            generateNextRandomNewPiece()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.getPrevisualisationPiece()
            }
            if isGameLost() { endGame() }
        }
    }
    
    // Cancel & reset the board timer.
    func resetTimer() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    // Speed up the timer speed.
    func speedUpTimer() {
        resetTimer()
        speed = 0.01
        startTimer()
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
        if chrono.second > 0 {
            chrono.second -= 1
        } else if chrono.minute > 0 {
            chrono.minute -= 1
            chrono.second += 59
        } else {
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
    
    // Check if one of the squares is beyond the top limit.
    func isGameLost() -> Bool {
        let firstThreeRows = rowsIndices.prefix(3)
        for rowIndex in firstThreeRows {
            if rowIndex.contains(where: { tetris.squares[$0] != .clear }) {
                return true
            }
        }
        return false
    }
    
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
        piece = Piece.pieces.randomElement()!
        nextPiece = Piece.pieces.randomElement()!
        previsualisationPiece = piece
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
        highscores.append(HighscoreModel(icon: "person.fill", color: .powderBlue, score: tetris.score))
        resetAllTimers()
        isAlertShowing.toggle()
    }
    
    // Transform the dropping piece into colored squares on the board.
    func createPieceOnBoard() {
        piece.position.forEach { tetris.squares[$0] = piece.color }
    }
    
    // Generate a random new dropping piece.
    func generateRandomNewPiece() {
        switch nextPiece.name {
        case "J Block":
            piece = Piece.jBlock
        case "L Block":
            piece = Piece.lBlock
        case "O Block":
            piece = Piece.oBlock
        case "S Block":
            piece = Piece.sBlock
        case "T Block":
            piece = Piece.tBlock
        case "Z Block":
            piece = Piece.zBlock
        default:
            piece = Piece.iBlock
        }
    }
    
    // Generate next random dropping piece.
    func generateNextRandomNewPiece() {
        nextPiece = Piece.pieces.randomElement()!
    }
    
    // Move the dropping piece one square down.
    func dropPiece() {
        piece.position.indices.forEach { piece.position[$0] += columnsIndices.count }
    }
    
    // Previsualisation of the dropping piece.
    func getPrevisualisationPiece() {
        previsualisationPiece = piece
        repeat {
            previsualisationPiece.position.indices.forEach { previsualisationPiece.position[$0] += columnsIndices.count }
        } while !isPieceOnLastRow(piece: previsualisationPiece) && !isPieceCollidingBottom(piece: previsualisationPiece)
    }
    
    // Level Up
    func LevelUp() {
        if tetris.lines > tetris.nextLevel {
            tetris.level += 1
        }
    }
    
    // MARK: - Piece conditions on board edges.
    
    // Check if the dropping piece is on the left edge.
    func isPieceOnLeftEdge() -> Bool {
        if let firstColumn = columnsIndices.first {
            let isPieceOnFirstColumn = firstColumn.contains(where: { piece.position.contains($0) })
            if isPieceOnFirstColumn {
                return true
            }
        }
        return false
    }
    
    // Check if the dropping piece is on the right edge.
    func isPieceOnRightEdge() -> Bool {
        if let lastColumn = columnsIndices.last {
            let isPieceOnLastColumn = lastColumn.contains(where: { piece.position.contains($0) })
            if isPieceOnLastColumn {
                return true
            }
        }
        return false
    }
    
    // Check if the dropping piece is on the last row.
    func isPieceOnLastRow(piece: Piece) -> Bool {
        if let lastRow = rowsIndices.last {
            if lastRow.contains(where: { piece.position.contains($0) }) {
                return true
            }
        }
        return false
    }
    
    // Check if the dropping piece is on the last row.
    func isPrevisualisationPieceOnLastRow() -> Bool {
        if let lastRow = rowsIndices.last {
            if lastRow.contains(where: { previsualisationPiece.position.contains($0) }) {
                return true
            }
        }
        return false
    }
    
    // Check if the dropping piece is on the edges
    func isOnEdges() -> Bool {
        isPieceOnLeftEdge() || isPieceOnRightEdge() || isPieceOnLastRow(piece: piece) ? true : false
    }
    
    // MARK: - Piece collisions conditions
    
    // Check if the dropping piece is colliding with the next bottom colored square on the board.
    func isPieceCollidingBottom(piece: Piece) -> Bool {
        let colorsIndices = boardIndices.filter { tetris.squares[$0] != .clear }
        let nextBottomSquaresIndices = colorsIndices.map { $0 - 10 }
        return piece.position.contains(where: { nextBottomSquaresIndices.contains($0) }) ? true : false
    }
    
    // Check if the dropping piece is colliding with the next left colored square on the board.
    func isPieceCollidingHorizontally(by amounts: [Int]) -> Bool {
        var colorsIndices = boardIndices.filter { tetris.squares[$0] != .clear }
        for amount in amounts {
            colorsIndices.append(contentsOf: colorsIndices.map { $0 + amount })
        }
        return piece.position.contains(where: { colorsIndices.contains($0) }) ? true : false
    }
    
    // MARK: - Squares conditions
    
    // Check if a square is clear
    func isSquareClear(index: Int) -> Bool {
        tetris.squares[index] == .clear ? true : false
    }
    
    // Check if a square index exists
    func isSquareIndexExists(index: Int) -> Bool {
        boardIndices.contains(index) ? true : false
    }
    
    // Check if a colored square can fall by checking the next square below.
    func isSquareCanDrop(index: Int) -> Bool {
        if isSquareIndexExists(index: getNextBottomSquareIndex(index: index)) && isSquareClear(index: getNextBottomSquareIndex(index: index)) {
            return true
        }
        return false
    }
    
    // Check if a row is full of colored squares
    func isRowFullColored(row: [Int]) -> Bool {
        if row.allSatisfy({ tetris.squares[$0] != .clear }) {
            return true
        }
        return false
    }
    
    // MARK: - Piece active actions
    
    // Rotate the dropping piece with an orientation
    func orientPiece(index: Int, orientation: PieceOrientation) {
        piece.position.indices.forEach { piece.position[$0] += piece.pattern[index][$0] }
        piece.orientation = orientation
    }
    
    // Rotate the dropping piece in a repeating cycle of 4 stances.
    func rotatePiece() {
        kickWallIBlock(orientation: piece.orientation)
        kickWallBlock(orientation: piece.orientation)
        switch piece.orientation {
        case .top:
            orientPiece(index: 0, orientation: .trailing)
        case .trailing:
            if !isPieceCollidingHorizontally(by: [1]) && piece.name != "I Block" {
                orientPiece(index: 1, orientation: .bottom)
            } else if !isPieceCollidingHorizontally(by: [-1, 1, 2]) {
                orientPiece(index: 1, orientation: .bottom)
            }
        case .bottom:
            orientPiece(index: 2, orientation: .leading)
        case .leading:
            if !isPieceCollidingHorizontally(by: [-1]) && piece.name != "I Block" {
                orientPiece(index: 3, orientation: .top)
            } else if !isPieceCollidingHorizontally(by: [-2, -1, 1]) {
                orientPiece(index: 3, orientation: .top)
            }
        }
        getPrevisualisationPiece()
    }
    
    // Move the dropping piece on the right
    func movePieceRight() {
        let nextPositon = piece.position.map { $0 + 1 }
        guard boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !isPieceOnRightEdge() && !isPieceCollidingHorizontally(by: [-1]) {
            piece.position = nextPositon
            getPrevisualisationPiece()
        }
    }
    
    // Move the dropping piece on the left
    func movePieceLeft() {
        let nextPositon = piece.position.map { $0 - 1 }
        guard boardIndices.contains(where:  { nextPositon.contains($0 )}) else { return }
        if !isPieceOnLeftEdge() && !isPieceCollidingHorizontally(by: [1]) {
            piece.position = nextPositon
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
        var lineCounter = 0
        for rowIndex in Array(rowsIndices.reversed()) {
            if isRowFullColored(row: rowIndex) {
                lineCounter += 1
                clearLine(rowIndex: rowIndex)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.bringDownBlocks()
                }
                animateBackground()
            }
        }
        scoringPoints(numberOfLines: lineCounter)
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
            if isSquareCanDrop(index: index) {
                tetris.squares[getNextBottomSquareIndex(index: index)] = tetris.squares[index]
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
        
        if piece.name == "I Block" {
            switch orientation {
            case .top:
                if isPieceOnLastRow(piece: piece) || isPieceCollidingBottom(piece: piece) {
                    piece.position.indices.forEach { piece.position[$0] -= columnsIndices.count }
                }
            case .trailing:
                trailingKickWall.forEach { (index, value) in
                    if columnsIndices[index].contains(where: { piece.position.contains($0) }) {
                        piece.position.indices.forEach { piece.position[$0] += value }
                    }
                }
            case .bottom:
                piece.position.indices.forEach { piece.position[$0] += 0 }
            case .leading:
                leadingKickWall.forEach { (index, value) in
                    if columnsIndices[index].contains(where: { piece.position.contains($0) }) {
                        piece.position.indices.forEach { piece.position[$0] += value }
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
        
        if piecesNames.contains(piece.name) {
            switch orientation {
            case .top:
                if isPieceOnLastRow(piece: piece) {
                    piece.position.indices.forEach { piece.position[$0] -= columnsIndices.count }
                }
            case .trailing:
                trailingKickWall.forEach { (index, value) in
                    if columnsIndices[index].contains(where: { piece.position.contains($0) }) {
                        piece.position.indices.forEach { piece.position[$0] += value }
                    }
                }
            case .bottom:
                piece.position.indices.forEach { piece.position[$0] += 0 }
            case .leading:
                leadingKickWall.forEach { (index, value) in
                    if columnsIndices[index].contains(where: { piece.position.contains($0) }) {
                        piece.position.indices.forEach { piece.position[$0] += value }
                    }
                }
            }
        }
    }
    
    // MARK: - Useful functions & computed properties
    
    // Columns indices of the board
    var columnsIndices: [[Int]] {
        var separatedBoardIndices = Array(tetris.squares.indices).separate(into: 10)
        var columns = [[Int]](repeating: [], count: 10)
        
        for i in separatedBoardIndices.indices {
            for index in separatedBoardIndices.indices {
                if let firstIndex = separatedBoardIndices[index].first {
                    columns[i].append(firstIndex)
                    separatedBoardIndices[index].removeFirst()
                }
            }
        }
        return columns
    }
    
    // Rows indices of the board
    var rowsIndices: [[Int]] {
        Array(tetris.squares.indices).separate(into: 10)
    }
    
    // Indices of the board
    var boardIndices: [Int] {
        Array(tetris.squares.indices)
    }
    
    // Index of the next bottom square
    func getNextBottomSquareIndex(index: Int) -> Int {
        return index + columnsIndices.count
    }
    
    init() {
        speed = getGameSpeed()
    }
}
