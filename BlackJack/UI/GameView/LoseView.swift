//
//  LoseView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 04/09/2023.
//

import SwiftUI

struct LoseView: View {
    @EnvironmentObject var gameController: GameController
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("You have run out of balance!")
                .font(.title)
                .foregroundColor(.red)
                .padding()

            // An image button to reset the game and set initial values.
            Button(action: {dismiss()}) {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.orange)
                    .background(Color.white.cornerRadius(25))
                    .accessibility(addTraits: .isButton)
                    .onTapGesture {
    //                    ContentView()
                        gameController.reset()
                        gameController.change(to: .betting)
                        gameController.balance = 2500
                        gameController.bettingAmount = 50
                    }
            }
            .padding()
        }
    }
}

struct LoseView_Previews: PreviewProvider {
    static let gameController = GameController()
    
    static var previews: some View {
        LoseView()
            .environmentObject(gameController)
    }
}
