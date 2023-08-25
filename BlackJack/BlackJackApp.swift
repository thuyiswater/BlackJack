//
//  BlackJackApp.swift
//  BlackJack
//
//  Created by mai chieu thuy on 11/08/2023.
//

import SwiftUI

@main
struct BlackJackApp: App {
    @StateObject var gameController = GameController
    @StateObject var stragegyController = StragegyController
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameController)
                .environmentObject(stragegyController)
        }
    }
}
