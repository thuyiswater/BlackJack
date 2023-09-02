//
//  StrategyController.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import Foundation
import Combine

class StrategyController: ObservableObject {
    typealias Data = [String: [String: String]]

    @Published var showHint = false

    private var jsonHard: JSON?
    private var jsonSoft: JSON?
    private var jsonSplit: JSON?

    var hardHands: Data {
        guard let jsonHard = jsonHard else { return .init() }
        return createDictionaryOfDictionaries(from: jsonHard)
    }

    var softHands: Data {
        guard let jsonSoft = jsonSoft else { return .init() }
        return createDictionaryOfDictionaries(from: jsonSoft)
    }

    var splitHands: Data {
        guard let jsonSplit = jsonSplit else { return .init() }
        return createDictionaryOfDictionaries(from: jsonSplit)
    }

    init() { load() }

    private func loadFromPath(forResource resource: String) -> JSON? {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json"),
           let content = try? String(contentsOfFile: filepath) {
            return try? JSON(string: content)
        }
        return nil
    }

    func load() {
        jsonHard = loadFromPath(forResource: "BasicStrategy_Hard")
        jsonSoft = loadFromPath(forResource: "BasicStrategy_Soft")
        jsonSplit = loadFromPath(forResource: "BasicStrategy_Split")
    }

    func release() {
        jsonHard = nil
        jsonSoft = nil
        jsonSplit = nil
    }

    private func createDictionaryOfDictionaries(from json: JSON) -> Data {
        json.dictionary.mapValues { $0.dictionary.mapValues { $0.string } }
    }

    func generateHint(playerCards: [CardState], dealerCards: [CardState]) -> String? {
        let playerCardsBlackjackCount = playerCards.blackJackCount
        let dealerCardsBlackjackCount = dealerCards.blackJackCount

        guard
            playerCardsBlackjackCount.amount < 21,
            dealerCardsBlackjackCount.amount < 21
        else {
            return nil
        }

        // Split
        if playerCards[0].card.value.number == playerCards[1].card.value.number
            && playerCards.count == 2 {
            // Handle double A's special because of json format
            if playerCards[0].card.value == .ace {
                return splitHands["A"]!["\(dealerCardsBlackjackCount.amount)"]
            }
            return splitHands["\(playerCards[0].card.value.number)"]!["\(dealerCardsBlackjackCount.amount)"]
        }

        switch playerCardsBlackjackCount {
        case .soft(let value):
            return softHands["\(value)"]!["\(dealerCardsBlackjackCount.amount)"]
        case .hard(let value):
            return hardHands["\(value)"]!["\(dealerCardsBlackjackCount.amount)"]
        case .blackjack:
            return nil
        }
    }
}
