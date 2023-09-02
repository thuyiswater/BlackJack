//
//  CoinDeckView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct CoinDeckView: View {
    @EnvironmentObject var gameController: GameController

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    gameController.bettingAmount = 0
                }, label: {
                    Text("Clear")
                        .frame(minWidth: 100)
                        .padding()
                        .background(Color.white.cornerRadius(8))
                })

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
