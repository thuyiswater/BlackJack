//
//  ContentView.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct ContentView: View {
    // Declare environment objects for managing game and strategy state.
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController
    @State private var showLoseAlert = false // Add this line to track the alert state
    
    // Initialize the ContentView.
    init() {
        // Configure the appearance of the navigation bar.
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }

    var body: some View {
        // Create a ZStack to layer views on top of each other.
        ZStack {
            // Set the background color for the entire view.
            Color("background")
                .ignoresSafeArea()

            // Stack vertically arranged views in a VStack.
            VStack {
                // Display the game title.
                TitleView("BlackJack  ♥️♦️♣️♠️")

                Text("Winning Streak: " + String(gameController.consecutiveWins))
                    .font(.custom("Poppins-Medium", size: 17))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.top, -7.0)
                    .offset(x: -105)
                    
                // Display the player's current money balance.
                MoneyBoxView(amount: 2500)

                // Display the player's current money balance.
                HouseCardStack()
                // Display the player's card stack.
                PlayerCardStacks()

                Spacer()

                // Depending on the game state, display either the coin deck or game actions.
                if gameController.gameState == .betting {
                    CoinDeckView()
                        .padding(.vertical, 32)
                } else {
                    hints
                    outcomeButtons
                    GameActions()
                        .padding(.bottom, 32)
                }
            }
            
            // If the 'showDirections' flag is true, display directions overlay.
            if gameController.showDirections {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Close the directions overlay when tapped.
                        gameController.showDirections.toggle()
                    }
                // Show the info view with game directions.
                InfoView()
            }

            // If the 'showSettings' flag is true, display the settings overlay.
            if gameController.showSettings {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Close the settings overlay when tapped.
                        gameController.showSettings.toggle()
                    }

                // Show the settings view.
                SettingView()
            }
            
//            if gameController.balance < 9 {
//                Text("Hi")
//          }
            
        }
    }

    // Determine the text to display for the game outcome.
    var outcomeText: String {
        if case .outcome(let outcome) = gameController.gameState {
            return outcome.description
        }
        return "-"
    }

    // Define the outcome buttons that allow the player to take actions after a game outcome.
    var outcomeButtons: some View {
        Group {
            Text(outcomeText)
                .foregroundColor(.white)
                .bold()
                .fixedSize(horizontal: false, vertical: true)

            // Create a horizontal stack for outcome-related buttons.
            HStack {
                // Button to rebet the same amount.
                Button(action: {
                    gameController.change(to: .betting)
                }, label: {
                    Text("Rebet")
                        .bold()
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))

                // Button to rebet and deal new cards.
                Button(action: {
                    gameController.reset()
                    gameController.change(to: .playerTurn)
                }, label: {
                    Text("Rebet and deal")
                        .bold()
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))
            }
        }
        // Adjust the opacity of outcome buttons based on the game state.
        .opacity(outcomeText == "-" ? 0 : 1)
    }

    // Determine the hint text based on the current game state and strategy.
    var hintText: String {
        // Generate a hint using the strategy controller, player's cards, and house's cards.
        let hint = strategyController.generateHint(
            playerCards: gameController.playerCards,
            dealerCards: gameController.houseCards
        )

        // Map the hint code to a human-readable action word.
        let word: String
        switch hint {
        case "S":
            word = "stand"
        case "D":
            word = "double"
        case "P":
            word = "split"
        case "H":
            word = "hit"
        default:
            return ""
        }

        return "Hint: \(word.capitalized)"
    }

    var hints: some View {
        Group {
            // Display the hint text only if the strategy controller indicates it should be shown.
            if strategyController.showHint {
                Text(hintText)
            } else {
                // If the hint should not be shown, display an empty view.
                EmptyView()
            }
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let gameController = GameController()
    static let strategyController = StrategyController()
    
    static var previews: some View {
        ContentView()
            .environmentObject(gameController)
            .environmentObject(strategyController)
    }
}

