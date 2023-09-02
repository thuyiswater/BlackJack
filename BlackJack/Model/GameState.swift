//
//  GameState.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import Foundation

enum GameState: Equatable {
    enum OutcomeState: Equatable {
        case houseWin
        case playerWin
        case houseBust
        case playerBust
        case push
        case playerBlackjack
        case houseBlackjack
        case multiple([OutcomeState])

        var description: String {
            switch self {
            case .houseWin:
                return " The House wins 🙁"
            case .playerWin:
                return "You win! 🎉"
            case .houseBust:
                return "You win. The House busted. 🥳"
            case .playerBust:
                return "Dealer wins. You busted. 🪦"
            case .push:
                return "Push. 👉👈"
            case .playerBlackjack:
                return "Wooo! You got a Blackjack! 🎰"
            case .houseBlackjack:
                return "No luck. The House Blackjack. 🎰"
            case .multiple(let outcomes):
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

    case outcome(OutcomeState)

    var description: String {
        switch self {
        case .betting, .playerTurn, .houseTurn:
            return "\(self)"
        case .outcome(let outcome):
            return "Outcome: \(outcome.description)"
        }
    }
}
