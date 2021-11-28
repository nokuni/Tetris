//
//  KeyPadView.swift
//  Tetris
//
//  Created by Yann Christophe Maertens on 27/11/2021.
//

import SwiftUI
import Combine

struct KeyPadView: View {
    private static let thresholds = (slow: TimeInterval(0.3), fast: TimeInterval(0.01))
    private static let timeToMax = TimeInterval(0.5)
    @State private var isRunning = false
    @State private var startDate: Date? = nil
    @State private var timer: Timer? = nil
    var action: (() -> Void)?
    var image: String
    var height: CGFloat
    var cancellables: Set<AnyCancellable>
    
    var gesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { _ in startRunning() }
            .onEnded { _ in stopRunning() }
    }
    var body: some View {
        Button(action: {
            
        }) {
            Image(systemName: image)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: height)
                .background(Color.leadBlack.shadow(color: .white, radius: 0, x: 3, y: 3))
                .padding(.horizontal, 5)
                .disabled(cancellables.isEmpty && action == nil)
                .gesture(gesture)
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            action?()
                        }
                )
        }
    }
    private func startRunning() {
        guard isRunning == false else { return }
        isRunning = true
        startDate = Date()
        timer = Timer.scheduledTimer(withTimeInterval: Self.thresholds.slow, repeats: true, block: timerFired)
    }
    private func timerFired(timer: Timer) {
        guard let startDate = self.startDate else { return }
        action?()
        let timePassed = Date().timeIntervalSince(startDate)
        let newSpeed = Self.thresholds.slow - timePassed * (Self.thresholds.slow - Self.thresholds.fast)/Self.timeToMax
        let nextFire = Date().advanced(by: max(newSpeed, Self.thresholds.fast))
        self.timer?.fireDate = nextFire
    }
    private func stopRunning() {
        timer?.invalidate()
        isRunning = false
    }
}

struct KeyPadView_Previews: PreviewProvider {
    static var previews: some View {
        KeyPadView(image: "heart", height: 100, cancellables: [])
    }
}
