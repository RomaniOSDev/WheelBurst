//
//  MatchLevelManager.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import Foundation

class MatchLevelManager {
    private static let completedLevelsKey = "completedMatchLevels"
    
    static func markLevelCompleted(_ levelId: Int) {
        var completedLevels = getCompletedLevels()
        if !completedLevels.contains(levelId) {
            completedLevels.append(levelId)
            UserDefaults.standard.set(completedLevels, forKey: completedLevelsKey)
        }
    }
    
    static func isLevelCompleted(_ levelId: Int) -> Bool {
        return getCompletedLevels().contains(levelId)
    }
    
    static func getCompletedLevels() -> [Int] {
        return UserDefaults.standard.array(forKey: completedLevelsKey) as? [Int] ?? []
    }
    
    static func resetProgress() {
        UserDefaults.standard.removeObject(forKey: completedLevelsKey)
    }
}

