//
//  DealerCardStack.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import SwiftUI

struct DealerCardStack: View {
    @EnvironmentObject var gameController: GameController
    var body: some View {
        CardStack(cards: $gameController.houseCards,
                          didBust: gameController.houseBust)
                    .padding(.bottom, 32)
    }
}

struct DealerCardStack_Previews: PreviewProvider {
    static var previews: some View {
        DealerCardStack()
    }
}
