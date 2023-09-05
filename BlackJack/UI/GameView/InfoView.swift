//
//  InfoView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 02/09/2023.
//

import SwiftUI

struct InfoView: View {
    // Accesses the GameController environment object to control game-related state.
    @EnvironmentObject var gameController: GameController

    // Static constant containing the introduction and rules of the game.
    static let introduction = """
Overview:

The rules of blackjack are simple. Your goal is to get your deck of cards as close as you can to 21 without going over.

Ace cards can be worth either 1 or 11 points.

Jack, King, and Queen cards are worth 10 points.

Numbered cards 2-10 are worth their value.

Your turn:

On your turn, you can choose from four options.

Hit - When you hit, you are delt a card. Careful, remember you do not want to exceed 21.

Double - Think you have a good chance of winning if you are delt one card more? Double your bet and the dealer will give you exactly one more card.

Stand - This action will keep your cards as is and the dealer will take their turn.

Split - If you have two of the same card values (i.e. 2♠️ and 2♦️, 10♥️ and J♠️), then you can choose to split your hand into two decks, and another card will be dealt to each. You can then perform the above actions on each of those decks.

Dealer's turn:

The dealer will then take their turn by revealing/dealing cards until it reaches a value greater than or equal to 17.

Outcomes:

You win if:
- Your card count is greater than the dealer's (player bust).
- The dealer's hand count exceeds 21.
- Blackjack! Your first two cards total 21 (and the dealer does not also have a blackjack)

The dealer wins if:
- Your card count if greater than 21 (dealer bust).
- The dealer's card count is greater than yours.

If there is a tie in the player card count and dealer card count, you have a push and bets are returned. If you win, you get your bet back times 2. If you lose, the house takes your bet.

Blackjacks result in 2 times the amount you bet.
"""


    var body: some View {
        ZStack {
            // A rounded rectangle with a background color for the information screen.
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("background"))

            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        // An "X" button to close the information screen.
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30)
                            .padding([.top, .trailing])
                            .accessibility(addTraits: .isButton)
                            .onTapGesture {
                                gameController.showDirections.toggle()
                            }
                    }
                    // An image representing the app icon.
                    Image("app-icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .shadow(radius: 16)
                        .cornerRadius(24)
                        .padding()

                    // Welcoming text.
                    Text("Welcome to BlackJack")
                        .font(.custom("Poppins-Medium", size: 25))
                        .bold()
                        .foregroundColor(.white)
                        .padding()

                    // Text presenting the game introduction and rules.
                    Text(InfoView.introduction)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
        .padding(.vertical, 128)
        .padding(.horizontal, 32)
    }
}

struct Info_Previews: PreviewProvider {
    static let gameController = GameController()
    static var previews: some View {
        InfoView()
            .frame(width: 200, height: 500)
            .environmentObject(gameController)
    }
}
