//
//  BetAmountView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct BetAmountView: View {
    // Accesses the GameController environment object to retrieve the betting amount.
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            // Coin betting image
            Image("bet-coin")
                .resizable()
                .frame(width: 30, height: 30)
            // Text displaying the current betting amount
            Text("$\(gameController.bettingAmount)")
                .bold()
                .font(.custom("Poppins-Light", size: 17))
                .foregroundColor(.white)
        }
    }
}

struct BetAmountView_Previews: PreviewProvider {
    static let gameController = GameController()
    
    static var previews: some View {
        BetAmountView()
            .environmentObject(gameController)
    }
}

