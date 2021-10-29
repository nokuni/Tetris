//
//  CustomAlertView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct CustomAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresenting: Bool
    var score: Int
    var isGameLost: Bool
    var isTimedOut: Bool
    var startTimer: (() -> Void)?
    var startChronoTimer: (() -> Void)?
    var newGame: (() -> Void)?
    var body: some View {
        if isPresenting {
            ZStack {
                Color.leadBlack.opacity(0.7).ignoresSafeArea()
                AlertWindowView(isPresenting: $isPresenting, score: score, isGameLost: isGameLost, isTimedOut: isTimedOut, dismissAlert: dismissAlert, goBack: goBack, startTimer: startTimer, startChronoTimer: startChronoTimer, newGame: newGame)
            }
        }
    }
    func dismissAlert() {
        isPresenting.toggle()
    }
    func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresenting: .constant(false), score: 0, isGameLost: false, isTimedOut: false)
    }
}
