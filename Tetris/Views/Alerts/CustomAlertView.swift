//
//  CustomAlertView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct CustomAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isAlertShowing: Bool
    @Binding var isAdventureAlertShowing: Bool
    var adventure: Adventure?
    var score: Int
    var isGameLost: Bool
    var isTimedOut: Bool
    var startTimer: (() -> Void)?
    var startChronoTimer: (() -> Void)?
    var startCountdownTimer: (() -> Void)?
    var newGame: (() -> Void)?
    var body: some View {
        ZStack {
            if isAlertShowing {
                ZStack {
                    Color.leadBlack.opacity(0.7).ignoresSafeArea()
                    AlertWindowView(isPresenting: $isAlertShowing, score: score, isGameLost: isGameLost, isTimedOut: isTimedOut, dismissAlert: dismissAlert, goBack: goBack, startTimer: startTimer, startChronoTimer: startChronoTimer, newGame: newGame)
                }
            }
            if isAdventureAlertShowing {
                AdventureAlertWindowsView(isPresenting: $isAdventureAlertShowing, adventure: adventure, startCountdownTimer: startCountdownTimer, dismissAlert: dismissAdventureAlert)
            }
        }
    }
    func dismissAlert() {
        isAlertShowing.toggle()
    }
    func dismissAdventureAlert() {
        isAdventureAlertShowing.toggle()
    }
    func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isAlertShowing: .constant(false), isAdventureAlertShowing: .constant(false), adventure: Adventure(image: "slowmo", title: "New Dimension", message: "The gravity is different here, be careful.", lineCondition: 20, mode: .space), score: 0, isGameLost: false, isTimedOut: false)
    }
}
