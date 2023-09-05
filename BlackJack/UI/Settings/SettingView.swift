//
//  SettingView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 02/09/2023.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var gameController: GameController
    @EnvironmentObject var strategyController: StrategyController
    
    @State private var difficultyLevel: Double = UserDefaults.standard.double(forKey: "DifficultyLevel")
//    @State private var soundEnabled: Bool = true
//    @State private var bettingAmount: Double = 50.0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("background"))

            ScrollView {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .padding([.top, .trailing])
                            .accessibility(addTraits: .isButton)
                            .onTapGesture {
                                gameController.showSettings.toggle()
                            }
                    }

                    Text("Basic Strategy")
                        .bold()
                        .font(.custom("Poppins-Medium", size: 25))
                        .multilineTextAlignment(.leading)
                        .padding()

                    Toggle(isOn: $strategyController.showHint) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Show Hints")
                                .font(.custom("Poppins-Light", size: 17))
                                .bold()
                            Text("Display basic strategy hints to learn to optimize chance of win.")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.custom("Poppins-Light", size: 10))
                        }
                    }
                    .padding()
                    
                    Section(header: Text("Game Difficulty")) {
                        Slider(value: $difficultyLevel, in: 1.0...3.0, step: 1.0) {
                            Text("Difficulty Level")
                        }
                        Text("Current Difficulty: \(Int(difficultyLevel))")
                            .padding(.bottom, 20)
                    }
                    .onChange(of: difficultyLevel) { newValue in
                        UserDefaults.standard.set(newValue, forKey: "DifficultyLevel")
                    }
//                    Section(header: Text("Betting Amount")) {
//                        Slider(value: $bettingAmount, in: 10.0...500.0, step: 10.0) {
//                            Text("Betting Amount")
//                        }
//                        Text("Current Bet: $\(Int(bettingAmount))")
//                    }

                    key
                        .padding(.horizontal)

                    StrategyCharts()
                }
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 128)
        .padding(.horizontal, 32)
    }

    var key: some View {
        VStack(spacing: 8) {
            Text("Key")
                .font(.headline)

            HStack {
                Text("Hit")
                Spacer()
                ChartItem("H")
            }
            HStack {
                Text("Stand")
                Spacer()
                ChartItem("S")
            }
            HStack {
                Text("Double")
                Spacer()
                ChartItem("D")
            }
            HStack {
                Text("Split")
                Spacer()
                ChartItem("P")
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static let strategyController = StrategyController()
    
    static var previews: some View {
        SettingView()
            .environmentObject(strategyController)
    }
}

