//
//  CoinView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct CoinView: View {
    @EnvironmentObject var gameController: GameController
    
    static let size: CGFloat = 80
    let amount: Int
    
    var body: some View {
        Image("coin-\(amount)")
            .resizable()
            .frame(width: Self.size, height: Self.size)
            .accessibilityAddTraits(.isButton)
            .onTapGesture {
                gameController.bettingAmount += amount
            }
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView(amount: 500)
    }
}
