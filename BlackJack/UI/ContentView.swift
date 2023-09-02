//
//  ContentView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 11/08/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            VStack {
                TitleView("BlackJack♦️♥️♠️♣️")
                
                MoneyBoxView(amount: 2500)
                
                HouseCardStack()
                PlayerCardStacks()
                
                Spacer()
                
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
            
            if gameController.showDirections {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        gameController.showDirections.toggle()
                    }
                InfoView()
            }
            
            if gameController.showSettings {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        gameController.showSettings.toggle()
                    }
                SettingsView()
            }
        }
    }
    
    var outcomeText: String {
        if case.outcome(let outcome) = gameController.gameState {
            return outcome.description
        }
        return "-"
    }
    
    var outcomeButtons: some View {
        Group {
            Text(outcomeText)
                .foregroundColor(.white)
                .font(.custom("Poppins-Light", size: 20))
                .bold()
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                Button (action: {
                    gameController.change(to: .betting)
                }, label: {
                Text("Rebet")
                        .bold()
                        .font(.custom("Poppins-Light", size: 17))
                })
                .frame(minWidth: 100)
                .padding()
                .background(Color.white.cornerRadius(8))
            }
        }
        .opacity(outcomeText == "-" ? 0 : 1)
    }
    
    var hintText: String {
        let hint = strategyController.generateHint(
            playerCards: gameController.playerCards,
            dealerCards: gameController.houseCards
        )

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
            if strategyController.showHint {
                Text(hintText)
            } else {
                EmptyView()
            }
        }
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
