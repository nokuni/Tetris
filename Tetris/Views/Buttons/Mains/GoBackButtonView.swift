//
//  GoBackButtonView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 24/10/2021.
//

import SwiftUI

struct GoBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Image(systemName: "house.fill")
            .foregroundColor(.black)
            .font(.largeTitle)
            .padding()
            .background(
                Color.white
                    .border(Color.black, width: 5)
                    .cornerRadius(5)
            )
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct GoBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoBackButtonView()
    }
}
