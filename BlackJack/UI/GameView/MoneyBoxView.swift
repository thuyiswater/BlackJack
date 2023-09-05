//
//  MoneyBox.swift
//  BlackJack
//
//  Created by Austin Evans on 4/13/21.
//

import SwiftUI

struct MoneyBoxView: View {
    // Accesses the GameController environment object to interact with game data.
    @EnvironmentObject var gameController: GameController

    // Height of the MoneyBoxView.
    let height: CGFloat = 50

    // The current amount of money in the player's balance.
    let amount: Int

    var body: some View {
        ZStack {
            HStack {
                // A rounded rectangle with a gradient background to visually enhance the MoneyBoxView.
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(
                        gradient: .init(colors: [Color("purple-3"), Color("background")]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 1, y: 0.5)
                      ))
                    .frame(width: 200, height: height - 20)
                    .padding(.leading, 32)
                Spacer()
            }

            HStack(spacing: 8) {
                // Coin image
                Image("coin")
                    .resizable()
                    .frame(width: 50, height: 50)
                // Text displaying the player's balance.
                Text("$\(gameController.balance)")
                    .font(.system(size: height - 25))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, -8)
                    .transition(.scale(scale: 20))
                Spacer()
                // An image button to toggle the display of game directions.
                Image(systemName: "info.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.orange)
                    .background(Color.white.cornerRadius(25))
                    .accessibility(addTraits: .isButton)
                    .onTapGesture {
                        gameController.showDirections.toggle()
                    }

                // An image button to toggle the display of game settings.
                Image(systemName: "text.book.closed.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .accessibility(addTraits: .isButton)
                    .onTapGesture {
                        gameController.showSettings.toggle()
                    }
            }
        }
        .frame(height: height)
        .padding()
    }
}

struct MoneyBoxView_Previews: PreviewProvider {
    static let gameController = GameController()
    
    static var previews: some View {
        MoneyBoxView(amount: 50)
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.black)
            .environmentObject(gameController)
    }
}
