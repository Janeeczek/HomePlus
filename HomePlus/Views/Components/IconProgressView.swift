//
//  IconProgressView.swift
//  HomePlus
//
//  Created by Jan Mazurek on 18/06/2021.
//

import SwiftUI

struct IconProgressView: View {
    var message: String?
    @State private var isAnimating = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 0.5)
                .repeatForever(autoreverses: false)
    }
    private enum Dimensions {
        static let padding: CGFloat = 100
        static let bgColor = Color("Clear")
        static let cornerRadius: CGFloat =  20
    }
    
    init() {
        message = nil
        
    }

    init(_ message: String?) {
        self.message = message
    }

    var body: some View {
        VStack {
            if let message = message {
                //(message)
            } else {
                
                Badge()
                    
            }
        }
        .padding(Dimensions.padding)
        .background(Dimensions.bgColor)//.animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        .clipShape(RoundedRectangle(cornerRadius: Dimensions.cornerRadius))
    }

}

struct IconProgressView_Previews: PreviewProvider {
    static var previews: some View {
        IconProgressView()
    }
}
