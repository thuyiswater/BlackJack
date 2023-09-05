//
//  GameActions.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct GameActions: View {
    // Accesses the GameController environment object to interact with game data.
    @EnvironmentObject var gameController: GameController

    var body: some View {
        HStack {
            // Game action button for "Double Down" action.
            GameAction(actionType: .double, onTap: gameController.double)
                .opacity(gameController.doubleable ? 1 : 0.5)
                .disabled(!gameController.doubleable)// Disable the button if not available.
            
            // Game action button for "Split" action.
            GameAction(actionType: .split, onTap: gameController.split)
                .opacity(gameController.splittable ? 1 : 0.5)
                .disabled(!gameController.splittable)// Disable the button if not available.
            
            // Game action button for "Hit" action.
            GameAction(actionType: .hit, onTap: gameController.hit)
                .opacity(gameController.actionsEnabled ? 1 : 0.5)
            
            // Game action button for "Stand" action.
            GameAction(actionType: .stand, onTap: gameController.stand)
                .opacity(gameController.actionsEnabled ? 1 : 0.5)
        }
        .disabled(!gameController.actionsEnabled) // Disable all buttons if game actions are not enabled.
        .animation(.easeInOut)
    }
}

struct GameActions_Previews: PreviewProvider {
    static var previews: some View {
        GameActions()
    }
}
