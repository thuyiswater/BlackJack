//
//  GameActionType.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import Foundation

enum GameActionType: String {
    case double
    case split
    case hit
    case stand

    var name: String {
        return rawValue.capitalized
    }
}
