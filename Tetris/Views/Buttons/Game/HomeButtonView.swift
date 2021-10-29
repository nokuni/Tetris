//
//  HomeButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct HomeButtonView: View {
    var stopTimer: (() -> Void)?
    @Binding var isPresenting: Bool
    var body: some View {
        Button(action: {
            stopTimer?()
            isPresenting.toggle()
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .border(Color.black, width: 5)
                    .cornerRadius(5)
                Image(systemName: "house.fill")
                    .font(.title)
                    .foregroundColor(.black)
            }
        }
        .offset(x: 170, y: 0)
    }
}

struct HomeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HomeButtonView(isPresenting: .constant(false))
    }
}
