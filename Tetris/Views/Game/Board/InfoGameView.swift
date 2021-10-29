//
//  InfoGameView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 26/10/2021.
//

import SwiftUI

struct InfoGameView: View {
    var level: Int
    var score: Int
    var lines: Int
    var body: some View {
        HStack {
            Text("Level \(level)")
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
            Text("\(score)")
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
            Text("Lines \(lines)")
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity)
        }
        .foregroundColor(.black)
        .font(.system(.title3, design: .monospaced))
    }
}

struct InfoGameView_Previews: PreviewProvider {
    static var previews: some View {
        InfoGameView(level: 0, score: 0, lines: 0)
    }
}
