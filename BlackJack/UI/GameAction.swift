//
//  GameAction.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct GameAction: View {
    static let size: CGFloat = 75
    
    let actionType: GameActionType
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Image(actionType.rawValue)
                .resizable()
                .frame(width: Self.size, height: Self.size)
            Text(actionType.name)
                .font(.custom("Poppins-Light", size: 20))
                .foregroundColor(.white)
        }
        .onTapGesture(perform: onTap)
    }
}

struct GameAction_Previews: PreviewProvider {
    static var previews: some View {
        GameAction(actionType: .hit, onTap: {})
    }
}
