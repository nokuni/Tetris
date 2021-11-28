//
//  BonusView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import SwiftUI

struct TextAnimationView: View {
    @Binding var isShowing: Bool
    var body: some View {
        Text("Fantastic")
            .foregroundColor(.black)
            .font(.system(size: 50, weight: .bold, design: .default))
            .opacity(isShowing ? 1 : 0)
    }
}

struct TextAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TextAnimationView(isShowing: .constant(false))
    }
}
