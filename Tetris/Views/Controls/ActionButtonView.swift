//
//  RotateButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI
import Combine

struct ActionButtonView: View {
    var image: String
    var action: (() -> Void)?
    var body: some View {
        Button(action: {
            action?()
        }) {
            ZStack {
                Circle()
                    .foregroundColor(.leadBlack)
                    .shadow(color: .white, radius: 0, x: 3, y: 3)
                Image(systemName: image)
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ActionButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ActionButtonView(image: "heart.fill")
    }
}
