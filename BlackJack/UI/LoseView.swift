//
//  LoseView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 04/09/2023.
//

import SwiftUI

struct LoseView: View {
    @EnvironmentObject var gameController: GameController
    @State var loseAlert: Bool = false
    @State private var displayPopupMessage: Bool = false
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            Text("You have run out of balance!")
                .font(.title)
                .foregroundColor(.red)
                .padding()

            Button("Restart Game") {
                // Implement logic to reset the game or navigate to the start screen
            }
            .padding()
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Game Over"),
                message: Text("You have run out of balance!"),
                primaryButton: .default(Text("Restart Game")) {
                    
                    isShowingAlert = false
                },
                secondaryButton: .cancel()
            )
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
