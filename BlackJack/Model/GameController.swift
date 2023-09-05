//
//  GameController.swift
//  BlackJack
//
//  Created by mai chieu thuy on 25/08/2023.
//

import Foundation
import Combine

class GameController: ObservableObject {
    // Directions
    @Published var showDirections = false
    @Published var showSettings = false

    // Game states
    @Published var gameState: GameState = .betting
    @Published var balance = 2500
    @Published var bettingAmount = 50

    // Cards
    @Published var playerCards = [CardState]()
    @Published var houseCards = [CardState]()

    // Busts
    @Published var playerBust = false
    @Published var houseBust = false
    @Published var splitBust = false

    // Split
    @Published var splitCards = [CardState]()
    @Published var splitDeckActive = false

    @Published var consecutiveWins: Int = 0
    @Published var countRound = 0
    @Published var showEndView = false
    
    var isSplit: Bool {
        !splitCards.isEmpty
    }

    var actionsEnabled: Bool {
        gameState == .playerTurn
    }

    var splittable: Bool {
        actionsEnabled &&
            playerCards.count == 2 &&
            playerCards.first!.card.isEquivalentInValue(to: playerCards.last!.card) &&
            !isSplit // Prevents double split
    }

    var doubleable: Bool {
        actionsEnabled && ((playerCards.count == 2 && !splitDeckActive) ||
                            (splitCards.count == 2 && splitDeckActive))
    }

    init() {
        change(to: .betting)
    }

    func reset() {
        playerCards = [.init(isHidden: true), .init(isHidden: true)]
        houseCards = [.init(isHidden: true), .init(isHidden: true)]
        splitCards = []

        playerBust = false
        houseBust = false
        splitBust = false
    }

    func deal() {
        playerCards.forEach { $0.isHidden.toggle() }
        houseCards.first?.isHidden.toggle()

        if playerCards.blackJackCount == .blackjack {
            print("Player Blackjack!")
            change(to: .houseTurn)
            return
        }

        if houseCards[0].card.value == .ace, houseCards[1].card.value.number == 10 {
            print("The House blackjack!")
            change(to: .houseTurn)
        }

        print(playerCards)
    }

    func dealHouseCard() {

        while !playerBust,
           houseCards.blackJackCount.amount < 17,
           playerCards.blackJackCount != .blackjack {
            houseCards.append(.init(isHidden: false))
        }

        let houseCardsCount = houseCards.blackJackCount.amount
        let playerCardsCount = playerCards.blackJackCount.amount

        let outcome: GameState.OutcomeState

        if playerCardsCount > 21 {
            outcome = .playerBust
        } else if houseCardsCount == playerCardsCount {
            outcome = .push
        } else if houseCardsCount == 21 && houseCards.count == 2 {
            outcome = .houseBlackjack
        } else if playerCardsCount == 21 && playerCards.count == 2 {
            outcome = .playerBlackjack
        } else if houseCardsCount > 21 {
            houseBust = true
            outcome = .houseBust
        } else if playerCardsCount > houseCardsCount {
            outcome = .playerWin
        } else {
            outcome = .houseWin
        }

        if isSplit {
            change(to: .outcome(.multiple([outcome, splitOutcome()])))
        } else {
            change(to: .outcome(outcome))
        }
    }

    func stand() {
        guard gameState == .playerTurn else { return }

        if isSplit && !splitDeckActive {
            splitDeckActive = true
        } else {
            change(to: .houseTurn)
        }
    }

    func hit() {
        guard gameState == .playerTurn else { return }

        print("hit")

        if splitDeckActive {
            splitCards.append(.init(isHidden: false))

            let cardCount = splitCards.blackJackCount.amount

            if cardCount > 21 {
                print("Player bust")
                splitBust = true
                change(to: .houseTurn)
            }

            if cardCount == 21 {
                print("Auto-stand on 21")
                change(to: .houseTurn)
            }
        } else {
            playerCards.append(.init(isHidden: false))

            let cardCount = playerCards.blackJackCount.amount

            if cardCount > 21 {
                print("Player bust")
                playerBust = true

                if isSplit && !splitDeckActive {
                    splitDeckActive = true
                } else {
                    change(to: .houseTurn)
                }
            }

            if cardCount == 21 {
                print("Auto-stand on 21")
                if isSplit && !splitDeckActive {
                    splitDeckActive = true
                } else {
                    change(to: .houseTurn)
                }
            }
        }
    }

    func split() {
        guard gameState == .playerTurn, splittable else { return }
        print("split")

        splitCards.append(playerCards.popLast()!)

        // Deal random new cards
        splitCards.append(.init(isHidden: false))
        hit() // does append to player cards

        balance -= bettingAmount
    }

    func double() {
        guard gameState == .playerTurn, doubleable else { return }
        print("double")

        if splitDeckActive {
            splitCards.append(.init(isHidden: false))
        } else {
            playerCards.append(.init(isHidden: false))
        }

        // TODO: Handle double balance for split case
        balance -= bettingAmount
        bettingAmount *= 2

        if splitDeckActive {
            splitBust = playerCards.blackJackCount.amount > 21
        } else {
            playerBust = playerCards.blackJackCount.amount > 21
        }

        print("Player bust")

        if isSplit && !splitDeckActive {
            splitDeckActive = true
        } else {
            change(to: .houseTurn)
        }
    }

    func change(to newState: GameState) {
        gameState = newState
        switch newState {
        case .betting:
            reset()
            if balance < 9 {
                showEndView = true
            }
        case .playerTurn:
            if balance < 9 {
                showEndView = true
                deal()

            } else if bettingAmount > balance {
                bettingAmount = balance
                balance = 0
                deal()
            }
            else {
                balance -= bettingAmount
                print("New balance \(balance)")
                deal()
            }
        case .houseTurn:
            splitDeckActive = false
            houseCards.last?.isHidden = false
            dealHouseCard()
        case .outcome(let outcome):
            print(outcome)
            updateBalance(for: outcome)
        }
        print("New state \(newState)")
    }

    func splitOutcome() -> GameState.OutcomeState {
        let splitCardsCount = splitCards.blackJackCount.amount
        let houseCardsCount = houseCards.blackJackCount.amount

        if splitCardsCount == 21 && splitCards.count == 2 {
            return .playerBlackjack
        } else if splitCardsCount > 21 {
            return .playerBust
        } else if houseCardsCount == splitCardsCount {
            return .push
        } else if splitCardsCount > houseCardsCount {
            return .playerWin
        } else if houseCardsCount > 21 {
            return .houseBust
        } else {
            return .houseWin
        }
    }

    func updateBalance(for outcome: GameState.OutcomeState) {
        switch outcome {
        case .playerBlackjack:
            balance += bettingAmount + (bettingAmount * 2)
            consecutiveWins += 1 // Increment consecutive wins
        case .houseBust, .playerWin:
            balance += bettingAmount * 2
            consecutiveWins += 1 // Increment consecutive wins
        case .push:
            balance += bettingAmount
            consecutiveWins = 0 // Reset consecutive wins on a push
        case .houseBlackjack, .houseWin, .playerBust:
            print("House win of $\(bettingAmount)")
            consecutiveWins = 0 // Reset consecutive wins
        case .multiple(let outcomes):
            outcomes.forEach { updateBalance(for: $0) }
        }
    }
    
    func adjustBettingAmount() {
        let difficultyLevel = 1.0

        if difficultyLevel == 2 {
            bettingAmount *= 2
        } else if difficultyLevel == 3 {
            bettingAmount *= 3
        }
    }
    
    
}
