//
//  Card.swift
//  BlackJack
//
//  Created by mai chieu thuy on 11/08/2023.
//

import Foundation
import SwiftUI

struct Card: Identifiable, Hashable, CustomDebugStringConvertible{
    var debugDescription: String {
        "\(value.display)\(suit.rawValue)"
    }
    
    enum Suit: String, Hashable, CaseIterable {
        case heart
        case diamond
        case club
        case spade
        
        var imageName: String {
            switch self {
            case.heart:
                return "suit.heart.fill"
            case.diamond:
                return "suit.diamond.fill"
            case.club:
                return "suit.club.fill"
            case.spade:
                return "suit.spade.fill"
            }
        }
        
        var cardColor: Color {
            switch self {
            case.heart, .diamond:
                return .red
            case.club, .spade:
                return .black
            }
        }
    }
    
    enum Value: Hashable, Equatable {
        static let allCases: [Value] = [ .ace, .king, .queen, .jack] + (2...10).map {.number($0)}
        
        case ace
        case king
        case queen
        case jack
        case number(Int)
        
        var display: String {
            switch self {
            case.ace:
                return "A"
            case.king:
                return "k"
            case.queen:
                return "Q"
            case.jack:
                return "J"
            case.number(let value):
                return "\(value)"
            }
        }
        
        var number: Int {
            switch self {
            case.ace:
                return 1
            case.king, .queen, .jack:
                return 10
            case.number(let value):
                return value
            }
        }
        static func == (lhs: Value, rhs: Value) -> Bool {
            return lhs.number == rhs.number;
        }
    }
    
    let id = UUID()
    let value: Value
    let suit: Suit
    
    init() {
        value = Value.allCases.randomElement()!
        suit = Suit.allCases.randomElement()!
    }
    
    init(value: Value, suit: Suit){
        self.value = value
        self.suit = suit
    }
    
    func isEquivalentInValue(to other: Card) -> Bool {
        value.number == other.value.number
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(value)
        hasher.combine(suit)
    }
}
