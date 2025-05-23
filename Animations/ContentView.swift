//
//  ContentView.swift
//  Animations
//
//  Created by BeastMode on 5/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNotified: Bool = false

    var body: some View { 
        
        HStack {
            
            Button("push me"){
                isNotified.toggle()
            }
            
            Image (systemName: "bell")
                .resizable ( )
                .frame(width: 44, height: 44)
                .foregroundStyle(.pink)
                .phaseAnimator ([ .initial,
                                 NotifyAnimationPhase.lift, NotifyAnimationPhase.shakeLeft, NotifyAnimationPhase.shakeRight, NotifyAnimationPhase.shakeLeft,
                                 NotifyAnimationPhase.shakeRight], trigger: isNotified) { content, phase in
                    content
                        .scaleEffect (phase.scale)
                        .rotationEffect(.degrees(phase.rotationDegress), anchor: .top)
                        .offset(y: phase.yOffset)
                }
            animation: { phase in
                switch phase {
                case .initial, .lift: .spring (bounce: 0.5)
                case .shakeLeft, .shakeRight: .easeInOut(duration: 0.15)
                }
            }
        }
        .padding()

        
    }
}

#Preview {
    ContentView()
}

enum NotifyAnimationPhase: CaseIterable {
    case initial, lift, shakeLeft, shakeRight
    
    var yOffset: CGFloat {
        switch self {
        case .initial: 0
        case .lift, .shakeLeft, .shakeRight: -30
            
        }
    }
    
    var scale: CGFloat {
        switch self {
        case .initial: 1
        case .lift, .shakeLeft, .shakeRight: 1.2
        }
    }
    
    var rotationDegress: Double {
        switch self {
        case .initial, .lift: 0
        case .shakeLeft: -30
        case .shakeRight: 30
        }
    }
}
