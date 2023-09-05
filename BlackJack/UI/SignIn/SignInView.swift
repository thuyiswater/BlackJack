//
//  SignInView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 04/09/2023.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController
    @State private var username = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter your username")
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Let's Go")
                        .font(.custom("Poppins-Light", size: 20))
                        .foregroundColor(.black)
                }
                
                
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static let gameController = GameController()
    static let strategyController = StrategyController()
    
    static var previews: some View {
        SignInView()
            .environmentObject(gameController)
            .environmentObject(strategyController)
    }
}
