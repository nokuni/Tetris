//
//  CustomAlertView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct CustomAlertView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: TetrisViewModel
    var body: some View {
        ZStack {
            if vm.isAlertShowing {
                ZStack {
                    Color.leadBlack.opacity(0.7).ignoresSafeArea()
                    AlertWindowView(isPresenting: $vm.isAlertShowing, tetris: vm.tetris, dismissAlert: dismissAlert, goBack: goBack, resumeGame: vm.resumeGame, resumeChrono: vm.resumeChrono, startNewGame: vm.startNewGame)
                }
            }
            if vm.isAdventureAlertShowing {
                AdventureAlertWindowsView(isPresenting: $vm.isAdventureAlertShowing, tetris: vm.tetris, resumeCountdown: vm.resumeCountdown, dismissAlert: dismissAdventureAlert)
            }
        }
    }
    func dismissAlert() {
        vm.isAlertShowing.toggle()
    }
    func dismissAdventureAlert() {
        vm.isAdventureAlertShowing.toggle()
    }
    func goBack() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(vm: TetrisViewModel())
    }
}
