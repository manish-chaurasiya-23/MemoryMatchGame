//
//  CardModel.swift
//  MemoryMatchGame
//
//  Created by Manish Kumar on 31/01/25.
//

import Foundation

struct CardModel: Identifiable {
    let id: Int
    let emoji: String
    var isRevealed = false
    var isMatched = false
}


