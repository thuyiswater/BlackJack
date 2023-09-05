//
//  GameAction.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct GameAction: View {
    // Static constant defining the size of the game action button.
    static let size: CGFloat = 75

    // The type of game action associated with this button.
    let actionType: GameActionType

    // A closure to perform when the button is tapped.
    let onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Display an image associated with the game action.
            Image(actionType.rawValue)
                .resizable()
                .frame(width: Self.size, height: Self.size)
            // Display the name of the game action with bold white text.
            Text(actionType.name)
                .bold()
                .foregroundColor(.white)
        }
        .onTapGesture(perform: onTap) // Attach the onTap closure to the button's tap gesture.
    }
}

struct GameAction_Previews: PreviewProvider {
    static var previews: some View {
        GameAction(actionType: .hit, onTap: {})
    }
}
