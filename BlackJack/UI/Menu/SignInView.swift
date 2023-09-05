//
//  SignInView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 04/09/2023.
//

import SwiftUI

//struct User: Codable {
//    var id: UUID
//    var username: String
//    var winning_streak: String
//    var image: String
//}

struct SignInView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController
    @State private var name = ""

    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter your username")
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                TextField("Username", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                NavigationLink {
                    ContentView()
                } label: {
                    Text("Let's Go")
                        .font(.custom("Poppins-Light", size: 20))
                        .foregroundColor(.black)
                }
                .padding()
                
                NavigationLink(destination: LeaderBoard(name: $name)) {
                    Text("Leaderboard")
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
