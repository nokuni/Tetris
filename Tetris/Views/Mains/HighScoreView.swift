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
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            VStack {
                Text("HIGHSCORES")
                    .foregroundColor(.theme.accent)
                    .font(.system(size: 50, weight: .heavy, design: .monospaced))
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.theme.accent, lineWidth: 5)
                        .background(Color.theme.background)
                    ScrollView {
                        VStack(alignment: .leading) {
                            ForEach(vm.highscores, id: \.self) { highscore in
                                ScoreRowView(highscore: highscore)
                            }
                        }
                        .padding(.top)
                    }
                }
                GoBackButtonView()
            }
            .padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct HighScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoreView()
            .environmentObject(TetrisViewModel())
    }
}

struct HighscoreModel: Hashable {
    let icon: String
    let color: Color
    var score: Int
}

struct ScoreRowView: View {
    var highscore: HighscoreModel
    var body: some View {
        HStack {
            Image(systemName: highscore.icon)
                .font(.title2)
                .foregroundColor(highscore.color)
                .shadow(color: Color.black, radius: 0, x: 2, y: 2)
            Text("\(highscore.score)")
                .foregroundColor(.theme.accent)
                .font(.system(size: 20, weight: .heavy, design: .monospaced))
        }
        .padding(.leading)
        Rectangle()
            .foregroundColor(.theme.accent)
            .frame(width: 353, height: 5)
    }
}
