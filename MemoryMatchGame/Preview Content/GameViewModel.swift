//
//  GameViewModel.swift
//  MemoryMatchGame
//
//  Created by Manish Kumar on 31/01/25.
//

import SwiftUI

class GameViewModel: ObservableObject {
    @Published var cards: [CardModel] = []
    @Published var moves = 0
    @Published var isGameWon: Bool = false
    private var firstFlippedIndex: Int?
    var count = 0
    
    private let emojis = ["🐶", "🐱", "🐭", "🦊", "🐶", "🐱", "🐭", "🦊"]
    
    init() {
        startGame()
    }
    
    func startGame() {
        cards = []
        let shuffledEmojis = emojis.shuffled()
        for index in 0..<shuffledEmojis.count {
            let card = CardModel(id: index, emoji: shuffledEmojis[index])
            cards.append(card)
        }
        isGameWon = false
        moves = 0
    }
    
    func isCardTapped(index: Int) {
        guard index < cards.count else { return }
        guard !cards[index].isRevealed && !cards[index].isMatched else { return }
        guard count < 2 else { return }

        cards[index].isRevealed = true
        moves += 1
        count += 1
        
        if let firstFlippedIndex = firstFlippedIndex {
            if cards[index].emoji == cards[firstFlippedIndex].emoji {
                cards[index].isMatched = true
                cards[firstFlippedIndex].isMatched = true
                self.firstFlippedIndex = nil
                self.count = 0
                if isWon() {
                    self.isGameWon = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.cards[index].isRevealed = false
                    self.cards[firstFlippedIndex].isRevealed = false
                    self.firstFlippedIndex = nil
                    self.count = 0
                }
            }
        } else {
            firstFlippedIndex = index
        }
    }
    
    func isWon() -> Bool {
        for card in cards {
            if card.isMatched ==  false {
                return false
            }
        }
        return true
    }
}
