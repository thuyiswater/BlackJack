//
//  CoinDeckView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct CoinDeckView: View {
    // Accesses the GameController environment object to interact with game data.
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            HStack {
                // Button to clear the current bet amount.
                Button(action: {
                    gameController.bettingAmount = 0
                }, label: {
                    Text("Clear")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })

                // Button to initiate dealing the cards.
                Button(action: {
                    gameController.change(to: .playerTurn)
                }, label: {
                    Text("Deal")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })
            }
            HStack {
                // Display different coin values as selectable CoinView components.
                CoinView(amount: 500)
                CoinView(amount: 100)
                CoinView(amount: 50)
                CoinView(amount: 10)
            }
            .padding(.horizontal)
        }
    }
}

struct CoinDeckView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDeckView()
            .background(Color("background"))
    }
}
