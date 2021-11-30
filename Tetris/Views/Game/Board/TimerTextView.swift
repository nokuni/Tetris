//
//  TimerTextView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 29/10/2021.
//

import SwiftUI

struct TimerTextView: View {
    var chrono: ChronoModel?
    var body: some View {
        if let chrono = chrono {
            Text(String(format: "%02d:%02d", Int(chrono.minute), Int(chrono.second)))
                .foregroundColor(.leadBlack)
                .fontWeight(.bold)
                .font(.title3)
                .frame(maxWidth: .infinity)
            
        } else {
            Text("Timeless")
                .foregroundColor(.leadBlack)
                .fontWeight(.bold)
                .font(.title3)
                .frame(maxWidth: .infinity)
        }
    }
}


struct TimerTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimerTextView(chrono: nil)
    }
}
