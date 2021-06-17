//
//  HomePlusApp.swift
//  HomePlus
//
//  Created by Jan Mazurek on 17/06/2021.
//

import SwiftUI
import RealmSwift

let app = App(id: "homeplus-cetrp")

@main
struct HomePlusApp: SwiftUI.App {
    @StateObject var state = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(state)
        }
    }
}
