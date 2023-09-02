//
//  BetAmountView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct BetAmountView: View {
    @EnvironmentObject var gameController: GameController
    
    var body: some View {
        HStack {
            Image("bet-coin")
                .resizable()
                .frame(width: 30, height: 30)
            Text("$\(gameController.bettingAmount)")
                .bold()
                .font(.custom("Poppins-Light", size: 20))
                .foregroundColor(.white)
        }
    }
}

struct BetAmountView_Previews: PreviewProvider {
    static var previews: some View {
        BetAmountView()
    }
}
