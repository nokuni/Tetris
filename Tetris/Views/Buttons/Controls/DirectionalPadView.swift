//
//  DirectionalPadView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 20/10/2021.
//

import SwiftUI
import Combine

struct DirectionalPadView: View {
    var movingLeft: (() -> Void)?
    var movingRight: (() -> Void)?
    var speedUp: (() -> Void)?
    var cancellables: Set<AnyCancellable>
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                KeyPadView(action: movingLeft, image: "arrowtriangle.backward.fill", cancellables: cancellables)
                
                Image(systemName: "arrowtriangle.backward.fill")
                    .foregroundColor(.clear)
                    .font(.title)
                    .padding()
                    .background(Color.clear)
                
                KeyPadView(action: movingRight, image: "arrowtriangle.forward.fill", cancellables: cancellables)
            }
            KeyPadView(action: speedUp, image: "arrowtriangle.down.fill", cancellables: cancellables)
        }
    }
}

struct DirectionalPadView_Previews: PreviewProvider {
    static var previews: some View {
        DirectionalPadView(cancellables: [])
    }
}

struct KeyPadView: View {
    var action: (() -> Void)?
    var image: String
    var cancellables: Set<AnyCancellable>
    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: image)
                .foregroundColor(.white)
                .font(.title)
                .padding()
                .background(Color.black)
        }
        .disabled(cancellables.isEmpty && action == nil)
    }
}
