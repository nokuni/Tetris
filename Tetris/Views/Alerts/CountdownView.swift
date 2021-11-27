//
//  CountdownView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct CountdownView: View {
    var countdown: Int
    var body: some View {
        if countdown >= 0 {
            ZStack {
                Color.leadBlack.opacity(0.7).ignoresSafeArea()
                Rectangle()
                    .foregroundColor(.theme.background)
                    .frame(width: 200, height: 200)
                Text(countdown > 0 ? "\(countdown)" : "GO!")
                    .foregroundColor(.theme.accent)
                    .font(.system(size: 100, weight: .heavy, design: .monospaced))
                    .foregroundColor(.white)
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(countdown: 3)
    }
}
