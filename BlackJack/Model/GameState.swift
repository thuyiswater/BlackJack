//
//  GameState.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import Foundation


enum GameState: Equatable {
    enum OutComeState: Equatable {
        case houseWin
        case playerWin
        case houseBust
        case playerBust
        case push
        case houseBlackJack
        case playerBlackJack
        case multiple ([OutComeState])
        
        var description: String {
            switch self {
            case.houseWin:
                return "The House Win 🙁"
            case.playerWin:
                return "You win! 🎉"
            case.houseBust:
                return "You win. The House busted. 🥳"
            case.playerBust:
                return "The House wins. You busted. 🪦"
            case.push:
                return "Push. 👉👈"
            case.houseBlackJack:
                return "No luck. The House Blackjack. 🎰"
            case.playerBlackJack:
                return "Yasss! You got a Blackjack! 🎰"
            case.multiple(let outcomes):
                return outcomes.enumerated().reduce(into: "") { (acc, element) in
                    let (index, outcome) = element
                    acc += "\(index + 1)) \(outcome.description)\n"
                }
            }
        }
    }
    
    case betting
    case playerTurn
    case houseTurn
    case outcome(OutComeState)
    
    var description: String {
        switch self {
        case.betting, .playerTurn, .houseTurn:
            return "\(self)"
        case.outcome(let outcome):
            return "Outcome: \(outcome.description)"
        }
    }
}
