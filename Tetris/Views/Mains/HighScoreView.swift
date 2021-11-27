//
//  HighScoreSheetView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct HighScoreView: View {
    @EnvironmentObject var vm: TetrisViewModel
    var body: some View {
        List(vm.highscores.indices, id: \.self) { index in
            ScoreRowView(position: index + 1, highscore: vm.highscores[index])
        }
        .listStyle(.plain)
        .navigationTitle("Highscores")
    }
}

struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
            .environmentObject(TetrisViewModel())
    }
}

struct ScoreRowView: View {
    var position: Int
    var highscore: HighscoreModel
    var body: some View {
        HStack {
            switch position {
            case 1:
                Text("\(position)st")
            case 2:
                Text("\(position)nd")
            case 3:
                Text("\(position)rd")
            default:
                Text("\(position)th")
            }
            Text(highscore.name)
                .frame(maxWidth: .infinity)
            Text("\(highscore.score)")
                .frame(maxWidth: .infinity)
        }
        .font(Font.title.bold())
    }
}
