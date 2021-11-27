//
//  PiecePreview.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 23/10/2021.
//

import SwiftUI

struct PiecePreview: View {
    var piece: Piece
    var width: CGFloat
    var height: CGFloat
    var body: some View {
            Image(piece.image)
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
                .frame(maxWidth: .infinity)
    }
}

struct PiecePreview_Previews: PreviewProvider {
    static var previews: some View {
        PiecePreview(piece: Piece.oBlock, width: 100, height: 100)
    }
}
