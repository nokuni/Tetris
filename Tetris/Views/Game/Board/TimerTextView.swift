//
//  TimerTextView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 29/10/2021.
//

import SwiftUI

struct TimerTextView: View {
    var tetrisMode: TetrisMode?
    var chrono: ChronoModel
    var body: some View {
        if let tetrisMode = tetrisMode {
            if tetrisMode == .classic {
                Text(String(format: "%02d:%02d", Int(chrono.minute), Int(chrono.second)))
                    .foregroundColor(.black)
                    .fontWeight(.heavy)
                    .font(.system(.title, design: .monospaced))
            }
        }
    }
}


struct TimerTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTextView(chrono: ChronoModel(minute: 3.0, second: 0.0))
    }
}
