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
            HStack {
                Text("Pause")
                    .fontWeight(.bold)
                Image(systemName: "pause.fill")
                    .foregroundColor(.leadBlack)
                    .scaledToFit()
            }
            .font(.title3)
            .foregroundColor(.leadBlack)
        }
        .frame(maxWidth: .infinity)
    }
}

struct PauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PauseButtonView(isPresenting: .constant(false), width: 100, height: 100)
    }
}
