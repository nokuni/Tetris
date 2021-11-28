//
//  TetrisModel.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 22/10/2021.
//

import SwiftUI

struct TetrisModel: Equatable {
    var score: ScoreModel
    var squares: [Color]
    var piece: Piece = Piece.pieces.randomElement()!
    var nextPiece = Piece.pieces.randomElement()!
    var previsualisationPiece = Piece.oBlock
    
    // Columns indices of the board
    var columnsIndices: [[Int]] {
        var separatedBoardIndices = Array(squares.indices).separate(into: 10)
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
    var rowsIndices: [[Int]] { Array(squares.indices).separate(into: 10) }
    
    // Indices of the board
    var boardIndices: [Int] { Array(squares.indices) }
    
    // Index of the next bottom square
    func getNextBottomSquareIndex(index: Int) -> Int { index + columnsIndices.count }
    
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
    func isOnEdges() -> Bool { isPieceOnLeftEdge() || isPieceOnRightEdge() || isPieceOnLastRow(piece: piece) }
    
    // Check if the dropping piece is colliding with the next bottom colored square on the board.
    func isPieceCollidingBottom(piece: Piece) -> Bool {
        let colorsIndices = boardIndices.filter { squares[$0] != .clear }
        let nextBottomSquaresIndices = colorsIndices.map { $0 - 10 }
        return piece.position.contains(where: { nextBottomSquaresIndices.contains($0) })
    }
    
    // Check if the dropping piece is colliding with the next left colored square on the board.
    func isPieceCollidingHorizontally(by amounts: [Int]) -> Bool {
        var colorsIndices = boardIndices.filter { squares[$0] != .clear }
        for amount in amounts {
            colorsIndices.append(contentsOf: colorsIndices.map { $0 + amount })
        }
        return piece.position.contains(where: { colorsIndices.contains($0) })
    }
    
    // Check if a square is clear
    func isSquareClear(index: Int) -> Bool { squares[index] == .clear }
    
    // Check if a square index exists
    func isSquareIndexExists(index: Int) -> Bool { boardIndices.contains(index) }
    
    // Check if a colored square can fall by checking the next square below.
    func isSquareCanDrop(index: Int) -> Bool {
        isSquareIndexExists(index: getNextBottomSquareIndex(index: index)) && isSquareClear(index: getNextBottomSquareIndex(index: index))
    }
    
    // Check if a row is full of colored squares
    func isRowFullColored(row: [Int]) -> Bool { row.allSatisfy({ squares[$0] != .clear }) }
    
    // Check if one of the squares is beyond the top limit.
    func isGameLost() -> Bool {
        let firstThreeRows = rowsIndices.prefix(3)
        for rowIndex in firstThreeRows {
            if rowIndex.contains(where: { squares[$0] != .clear }) {
                return true
            }
        }
        return false
    }
    
    func isGameWon(adventure: Adventure?) -> Bool {
        if let adventure = adventure { return score.lines >= adventure.lineCondition }
        return false
    }
}

extension TetrisModel {
    static let byDefault = TetrisModel(score: ScoreModel(points: 0, lines: 0), squares: [Color](repeating: .clear, count: 230))
}
