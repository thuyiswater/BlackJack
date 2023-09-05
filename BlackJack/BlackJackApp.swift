//
//  BlackJackApp.swift
//  BlackJack
//
//  Created by mai chieu thuy on 11/08/2023.
//

import SwiftUI

@main
struct BlackJackApp: App {
    @StateObject var gameController = GameController()
    @StateObject var stragegyController = StrategyController()
    
    var body: some Scene {
        WindowGroup {
            SignInView()
                .environmentObject(gameController)
                .environmentObject(stragegyController)
        }
    }
}
