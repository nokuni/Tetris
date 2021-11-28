//
//  SpaceBackgroundView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import SwiftUI

struct SpaceBackgroundView: View {
    var randomX: CGFloat { CGFloat.random(in: -200...200) }
    var randomY: CGFloat { CGFloat.random(in: -400...400) }
    var randomSize: CGFloat { CGFloat.random(in: 0...0.03) }
    var body: some View {
        ZStack {
            ForEach(0..<100) { _ in
                Circle()
                    .foregroundColor(.white)
                    .scaleEffect(randomSize)
                    .offset(x: randomX, y: randomY)
            }
        }
    }
}

struct SpaceBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceBackgroundView()
    }
}
