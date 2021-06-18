/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view that displays a badge.
*/

import SwiftUI

struct Badge: View {
    static let rotationCount = 7
    @State private var isAnimating = false
    var foreverAnimation: Animation {
            Animation.linear(duration: 3.0)
                .repeatForever(autoreverses: false)
        
        //Animation.easeInOut(duration: 2).repeatForever()
    }
    var animation: Animation {
        Animation.linear(duration: 3)
        .repeatForever(autoreverses: false)
    }
    var badgeSymbols: some View {
        ForEach(0..<Badge.rotationCount) { index in
            RotatedBadgeSymbol(
                angle: .degrees(Double(index) / Double(Badge.rotationCount)) * 360.0
            )
            
        }
        
        .opacity(0.5)
    }

    var body: some View {
        ZStack {
            BadgeBackground()

            GeometryReader { geometry in
                badgeSymbols
                    //.animation(animation)
                    .scaleEffect(1.0 / 4.0, anchor: .top)
                    //.scaleEffect(true ? 1.0 / 2.0 :1.0 / 6.0, anchor: .center)
                            
                    //.animation(.interpolatingSpring(stiffness: 50, damping: 1))
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
                    //.effect
                    
                    .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
                    .animation(self.isAnimating ? foreverAnimation : .default)
                    
                    .onAppear { self.isAnimating = true
                       
                    }
                    .onDisappear { self.isAnimating = false }
            }
        }
        
        .scaledToFit()
        .rotationEffect(Angle(degrees: self.isAnimating ? 360 : 0.0))
        .animation(self.isAnimating ? foreverAnimation : .default)
        
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
