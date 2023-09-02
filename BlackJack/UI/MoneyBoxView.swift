//
//  MoneyBoxView.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

struct MoneyBoxView: View {
    @EnvironmentObject var gameController: GameController
    
    let height: CGFloat = 50
    let amount: Int
    
    var body: some View {
        ZStack {
            HStack {
                RoundedRectangle(cornerRadius: 4)
                    .fill(LinearGradient(
                        gradient: .init(colors: [Color("purple-3"), Color("background")]),
                        startPoint: .init(x: 0, y: 0.5),
                        endPoint: .init(x: 1, y: 0.5)))
                    .frame(width: 200, height: height - 20)
                    .padding(.leading, 32)
                Spacer()
            }
            
            HStack(spacing: 8) {
                Image("coin")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("$\(gameController.balance)")
                    .font(.custom("Poppins-Light", size: height - 25))
                    .bold()
                    .foregroundColor(.white)
                    .padding(.leading, -8)
                    .transition(.scale(scale: 20))
                Spacer()
                
                Image(systemName: "arrow.clockwise.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundColor(.orange)
                    .background(Color.white.cornerRadius(25))
                    .accessibilityAddTraits(.isButton)
                    .onTapGesture {
                        gameController.reset()
                        gameController.change(to: .betting)
                        gameController.balance = 2500
                        gameController.bettingAmount = 50
                    }
                
                Image(systemName: "text.book.closed.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(8)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .accessibilityAddTraits(.isButton)
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
    static var previews: some View {
        MoneyBoxView(amount: 50)
            .frame(width: 200, height: 50, alignment: .center)
            .background(Color.black)
    }
}
