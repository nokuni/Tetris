//
//  KeyPadView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import SwiftUI
import Combine

struct KeyPadView: View {
    var action: (() -> Void)?
    var image: String
    var height: CGFloat
    var cancellables: Set<AnyCancellable>
    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: image)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: height)
                .background(Color.leadBlack.shadow(color: .white, radius: 0, x: 3, y: 3))
        }
        .padding(.horizontal, 5)
        .disabled(cancellables.isEmpty && action == nil)
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView(image: "heart", height: 100, cancellables: [])
    }
}
