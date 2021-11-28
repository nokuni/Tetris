//
//  InfoGameView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 26/10/2021.
//

import SwiftUI

struct InfoGameView: View {
    var score: ScoreModel
    var body: some View {
        HStack {
            VStack {
                Text("Level")
                Text("\(score.level)")
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity)
            Text("\(score.points)")
                .fontWeight(.heavy)
                .font(.title)
                .frame(maxWidth: .infinity)
            VStack {
                Text("Lines")
                Text("\(score.lines)")
                    .fontWeight(.heavy)
            }
            .frame(maxWidth: .infinity)
        }
        .font(Font.title3.bold())
        .foregroundColor(.leadBlack)
    }
}

struct InfoGameView_Previews: PreviewProvider {
    static var previews: some View {
        InfoGameView(score: ScoreModel(points: 0, lines: 0))
    }
}
