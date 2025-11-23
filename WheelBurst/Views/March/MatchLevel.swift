//
//  MatchLevel.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import Foundation

struct MatchLevel: Identifiable {
    let id: Int
    let rows: Int
    let columns: Int
    let timeLimit: Int // в секундах
    
    var totalCards: Int {
        rows * columns
    }
    
    var pairsCount: Int {
        totalCards / 2
    }
    
    static let allLevels: [MatchLevel] = [
        // Уровни 1-3: поле 2x2
        MatchLevel(id: 1, rows: 2, columns: 2, timeLimit: 60),
        MatchLevel(id: 2, rows: 2, columns: 2, timeLimit: 50),
        MatchLevel(id: 3, rows: 2, columns: 2, timeLimit: 40),
        
        // Уровни 4-6: поле 3x2
        MatchLevel(id: 4, rows: 3, columns: 2, timeLimit: 70),
        MatchLevel(id: 5, rows: 3, columns: 2, timeLimit: 60),
        MatchLevel(id: 6, rows: 3, columns: 2, timeLimit: 50),
        
        // Уровни 7-9: поле 3x3
        MatchLevel(id: 7, rows: 3, columns: 3, timeLimit: 90),
        MatchLevel(id: 8, rows: 3, columns: 3, timeLimit: 80),
        MatchLevel(id: 9, rows: 3, columns: 3, timeLimit: 70)
    ]
}

// Изображения карточек
struct MatchCardImages {
    static let cardImages: [ImageResource] = [
        .card1, .card2, .card3, .card4, .card5, .card6
    ]
    
    static func getCardImages(for pairsCount: Int) -> [ImageResource] {
        Array(cardImages.prefix(pairsCount))
    }
}

