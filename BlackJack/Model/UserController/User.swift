//
//  User.swift
//  BlackJack
//
//  Created by mai chieu thuy on 05/09/2023.
//

import Foundation

struct User: Hashable, Codable, Identifiable {
    var id: UUID 
    var username: String
    var winning_streak: Int
    var image: String
}
