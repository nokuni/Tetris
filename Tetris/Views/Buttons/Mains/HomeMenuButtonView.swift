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
        .font(.system(size: 25, weight: .heavy, design: .monospaced))
        .foregroundColor(.black)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .background(
            Capsule()
                .stroke(Color.black, lineWidth: 5)
                .background(
                    Capsule()
                        .foregroundColor(color)
                )
        )
        .padding(.horizontal)
    }
}

struct HomeMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeMenuButtonView(image: "heart.fill", text: "CLASSIC", color: .orange)
    }
}
