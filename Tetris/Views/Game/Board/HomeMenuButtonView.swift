//
//  HomeMenuButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct HomeMenuButtonView: View {
    var image: String
    var text: String
    var color: Color
    var body: some View {
        HStack {
            Image(systemName: image)
            Text(text)
        }
        .font(Font.title.bold())
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .background(color.shadow(color: .black, radius: 0, x: 4, y: 4))
        .padding(.horizontal)
    }
}

struct HomeMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuButtonView(image: "heart.fill", text: "CLASSIC", color: .orange)
    }
}
