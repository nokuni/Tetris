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
            VStack {
                Text("Level")
                Text("\(level)")
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity)
            Text("\(score)")
                .fontWeight(.heavy)
                .font(.title)
                .frame(maxWidth: .infinity)
            VStack {
                Text("Lines")
                Text("\(lines)")
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity)
        }
        .font(Font.title3.bold())
        .foregroundColor(.black)
    }
}

struct InfoGameView_Previews: PreviewProvider {
    static var previews: some View {
        InfoGameView(level: 0, score: 0, lines: 0)
    }
}
