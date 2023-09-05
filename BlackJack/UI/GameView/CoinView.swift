//
//  CoinView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct CoinView: View {
    // Accesses the GameController environment object to interact with game data.
    @EnvironmentObject var gameController: GameController
    
    // Static constant defining the size of the coin view.
    static let size: CGFloat = 80
    let amount: Int
    
    var body: some View {
        // Display an image of the coin with a specific denomination.
        Image("coin-\(amount)")
            .resizable()
            .frame(width: Self.size, height: Self.size)
            .accessibilityAddTraits(.isButton) // Marks the coin as a button for accessibility.
            .onTapGesture {
                // When tapped, add the coin's denomination to the current bet amount.
                gameController.bettingAmount += amount
            }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(amount: 500)
    }
}
