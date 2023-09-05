//
//  LeaderBoard.swift
//  BlackJack
//
//  Created by mai chieu thuy on 05/09/2023.
//

import SwiftUI

struct LeaderBoard: View {
    @Binding var name: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(name)")
                    .font(.custom("Poppins-Light", size: 17))
            }
        }
    }
}

struct LeaderBoard_Previews: PreviewProvider {
    static var previews: some View {
        LeaderBoard(name: .constant("User"))
    }
}
