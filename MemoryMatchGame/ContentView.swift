//
//  ContentView.swift
//  MemoryMatchGame
//
//  Created by Manish Kumar on 31/01/25.
//
import SwiftUI
struct ContentView: View {
    @StateObject var viewModel = GameViewModel()
    let columns = [GridItem(.fixed(100), spacing: 4), GridItem(.fixed(100), spacing: 4), GridItem(.fixed(100), spacing: 4), GridItem(.fixed(100), spacing: 4)]

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.cards, id: \.id) { card in
                    CardView(card: card)
                        .onTapGesture {
                            viewModel.isCardTapped(index: card.id)
                        }
                }
            }
            Text("Moves: \(viewModel.moves)")
                .font(.headline)
                .padding()
            if viewModel.isGameWon {
                Text("Congralution you have won the Game in \(viewModel.moves) Moves")
                    .padding()
            }
            
            Button {
                viewModel.startGame()
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green)
                    .frame(width: .infinity, height: 50)
                    .overlay {
                        Text("Restart Game")
                    }
            }
            .padding()
            
        }
        .background(Color.red)
        .padding()
    }
}

struct CardView: View {
    let card: CardModel
    var body: some View {
        ZStack {
            if card.isRevealed || card.isMatched {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .overlay(
                        Text(card.emoji)
                            .font(.largeTitle)
                    )
                    .frame(width: 100, height: 100)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .frame(width: 100, height: 100)
            }
        }
    }
}


