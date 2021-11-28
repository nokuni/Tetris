//
//  AdventureView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 28/11/2021.
//

import SwiftUI

struct AdventureView: View {
    @ObservedObject var vm: TetrisViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Adventure.adventures, id: \.self) { adventure in
                    NavigationLink(destination: GameView()) {
                        AdventureMenuButtonView(adventure: adventure)
                    }
                    .simultaneousGesture(
                        TapGesture().onEnded { _ in
                            vm.setTetrisMode(mode: adventure.mode)
                            vm.setAdventure(adventure: adventure)
                        }
                    )
                }
            }
        }
        .navigationTitle("Adventure")
    }
}

struct AdventureView_Previews: PreviewProvider {
    static var previews: some View {
        AdventureView(vm: TetrisViewModel())
    }
}

struct AdventureMenuButtonView: View {
    var adventure: Adventure
    var body: some View {
        HStack {
            Image(systemName: adventure.image)
            Text(adventure.title)
                .padding()
        }
        .font(.title)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .padding()
    }
}
