//
//  MatchDetailView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 23/10/2021.
//

import SwiftUI

struct MatchDetailView: View {
    var title: String
    var amount: Int
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
            Text("\(amount)")
        }
        .font(.system(size: 13, weight: .heavy, design: .rounded))
        .padding()
    }
}

struct MatchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailView(title: "title", amount: 0)
    }
}
