//
//  MatchView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import SwiftUI

struct MatchCard: Identifiable {
    let id: UUID
    let cardImage: ImageResource
    let cardIndex: Int // Индекс для сравнения карточек
    var isFlipped: Bool = false
    var isMatched: Bool = false
    var isEmpty: Bool = false
    
    init(cardImage: ImageResource? = nil, cardIndex: Int = 0, isEmpty: Bool = false) {
        self.id = UUID()
        self.cardImage = cardImage ?? .card1
        self.cardIndex = cardIndex
        self.isEmpty = isEmpty
    }
}

struct MatchView: View {
    let level: MatchLevel
    @Environment(\.dismiss) var dismiss
    
    @State private var cards: [MatchCard] = []
    @State private var selectedCards: [UUID] = []
    @State private var timeRemaining: Int
    @State private var timer: Timer?
    @State private var isGameOver: Bool = false
    @State private var isWin: Bool = false
    @State private var matchedPairs: Int = 0
    
    init(level: MatchLevel) {
        self.level = level
        _timeRemaining = State(initialValue: level.timeLimit)
    }
    
    var body: some View {
        ZStack {
            Image(.mainBackImg)
                .resizable()
                .ignoresSafeArea()
            
            if isGameOver {
                gameOverView
            } else {
                gameView
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            setupGame()
            startTimer()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private var gameView: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button {
                    timer?.invalidate()
                    dismiss()
                } label: {
                    Image(.backBTN)
                        .resizable()
                        .frame(width: 85, height: 76)
                }
                
                Spacer()
                
                // Timer
                VStack(spacing: 5) {
                    Text("Time")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                    Text("\(timeRemaining)")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(timeRemaining <= 10 ? .red : .white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black.opacity(0.3))
                )
            }
            .padding()
            
            
            
            // Cards grid
            let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 10), count: level.columns)
            
            LazyVGrid(columns: gridColumns, spacing: 10) {
                ForEach(cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            if !card.isEmpty && !card.isFlipped && !card.isMatched && selectedCards.count < 2 {
                                flipCard(card.id)
                            }
                        }
                }
            }
            .padding(.horizontal)
            
            Image(.dictor)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
    }
    
    private var gameOverView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            if isWin {
                Image(.winMan)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Level \(level.id) Complete!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            } else {
                Image(.lossMan)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Button {
                dismiss()
            } label: {
                Image(.continueBTN)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 105)
            }
            
            Spacer()
        }
        .padding()
    }
    
    private func setupGame() {
        let cardImages = MatchCardImages.getCardImages(for: level.pairsCount)
        var newCards: [MatchCard] = []
        
        // Создаем пары карточек
        for (index, cardImage) in cardImages.enumerated() {
            newCards.append(MatchCard(cardImage: cardImage, cardIndex: index))
            newCards.append(MatchCard(cardImage: cardImage, cardIndex: index))
        }
        
        // Если количество карточек нечетное, добавляем пустую карточку
        if level.totalCards % 2 != 0 && newCards.count < level.totalCards {
            newCards.append(MatchCard(isEmpty: true))
        }
        
        // Перемешиваем карточки
        cards = newCards.shuffled()
    }
    
    private func flipCard(_ cardId: UUID) {
        guard let index = cards.firstIndex(where: { $0.id == cardId }) else { return }
        
        var updatedCards = cards
        updatedCards[index].isFlipped = true
        cards = updatedCards
        selectedCards.append(cardId)
        
        if selectedCards.count == 2 {
            checkMatch()
        }
    }
    
    private func checkMatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            guard selectedCards.count == 2,
                  let firstIndex = cards.firstIndex(where: { $0.id == selectedCards[0] }),
                  let secondIndex = cards.firstIndex(where: { $0.id == selectedCards[1] }) else {
                return
            }
            
            let firstCard = cards[firstIndex]
            let secondCard = cards[secondIndex]
            
            var updatedCards = cards
            
            if firstCard.cardIndex == secondCard.cardIndex && !firstCard.isEmpty && !secondCard.isEmpty {
                // Match found
                updatedCards[firstIndex].isMatched = true
                updatedCards[secondIndex].isMatched = true
                updatedCards[firstIndex].isFlipped = true
                updatedCards[secondIndex].isFlipped = true
                cards = updatedCards
                matchedPairs += 1
                
                // Check if all pairs are matched
                if matchedPairs == level.pairsCount {
                    timer?.invalidate()
                    isWin = true
                    isGameOver = true
                    // Сохраняем статус пройденного уровня
                    MatchLevelManager.markLevelCompleted(level.id)
                }
            } else {
                // No match, flip back
                updatedCards[firstIndex].isFlipped = false
                updatedCards[secondIndex].isFlipped = false
                cards = updatedCards
            }
            
            selectedCards.removeAll()
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                isGameOver = true
                isWin = false
            }
        }
    }
}

struct CardView: View {
    let card: MatchCard
    
    var body: some View {
        ZStack {
            if card.isEmpty {
                // Пустая карточка - не показываем ничего
                Color.clear
                    .frame(height: 80)
            } else {
                // Обратная сторона или лицевая сторона
                Image(card.isFlipped || card.isMatched ? card.cardImage : .closeCard)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 80)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(card.isMatched ? Color.green : Color.white.opacity(0.3), lineWidth: card.isMatched ? 3 : 2)
                    )
            }
        }
    }
}

#Preview {
    NavigationStack {
        MatchView(level: MatchLevel.allLevels[0])
    }
}

