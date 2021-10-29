//
//  PauseButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI
import Combine

struct PauseButtonView: View {
    @Binding var isPresenting: Bool
    var cancelTimer: (() -> Void)?
    var cancelChronoTimer: (() -> Void)?
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        Button(action: {
            cancelTimer?()
            cancelChronoTimer?()
            isPresenting.toggle()
        }) {
            Image(systemName: "pause.fill")
                .foregroundColor(.black)
                .font(.largeTitle)
                .scaledToFit()
                .padding()
                .background(Color.white)
        }
        .padding()
        .frame(maxWidth: width, maxHeight: height, alignment: .top)
    }
}

struct PauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PauseButtonView(isPresenting: .constant(false), width: 100, height: 100)
    }
}
