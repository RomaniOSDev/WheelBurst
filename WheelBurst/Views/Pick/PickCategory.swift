//
//  PickCategory.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import Foundation
import SwiftUI

enum PickCategory: String, CaseIterable {
    case flowers = "цветы"
    case fruits = "фрукты"
    case toys = "игрушки"
    case sweets = "сладости"
    case gifts = "подарки"
    case animals = "животные"
    case fish = "рыбы"
    case trees = "деревья"
    
    var displayName: String {
        return rawValue
    }
}

struct PickImage: Identifiable {
    let id: UUID = UUID()
    let category: PickCategory
    let imageName: String // Имя изображения в Assets
    
    init(category: PickCategory, imageName: String) {
        self.category = category
        self.imageName = imageName
    }
}

struct PickGameData {
    // Все изображения из Assets - по 3 картинки на каждую категорию
    static let allImages: [PickImage] = [
        // Цветы (3 картинки)
        PickImage(category: .flowers, imageName: "flower1"),
        PickImage(category: .flowers, imageName: "flower2"),
        PickImage(category: .flowers, imageName: "flower3"),
        
        // Фрукты (3 картинки)
        PickImage(category: .fruits, imageName: "fruit1"),
        PickImage(category: .fruits, imageName: "fruit2"),
        PickImage(category: .fruits, imageName: "fruit3"),
        
        // Игрушки (3 картинки)
        PickImage(category: .toys, imageName: "toy1"),
        PickImage(category: .toys, imageName: "toy2"),
        PickImage(category: .toys, imageName: "toy3"),
        
        // Сладости (3 картинки)
        PickImage(category: .sweets, imageName: "sweet1"),
        PickImage(category: .sweets, imageName: "sweet2"),
        PickImage(category: .sweets, imageName: "sweet3"),
        
        // Подарки (3 картинки)
        PickImage(category: .gifts, imageName: "gift1"),
        PickImage(category: .gifts, imageName: "gift2"),
        PickImage(category: .gifts, imageName: "gift3"),
        
        // Животные (3 картинки)
        PickImage(category: .animals, imageName: "animals1"),
        PickImage(category: .animals, imageName: "animals2"),
        PickImage(category: .animals, imageName: "animals3"),
        
        // Рыбы (3 картинки)
        PickImage(category: .fish, imageName: "fish1"),
        PickImage(category: .fish, imageName: "fish2"),
        PickImage(category: .fish, imageName: "fish3"),
        
        // Деревья (3 картинки)
        PickImage(category: .trees, imageName: "trees1"),
        PickImage(category: .trees, imageName: "trees2"),
        PickImage(category: .trees, imageName: "trees3")
    ]
    
    static func images(for category: PickCategory) -> [PickImage] {
        allImages.filter { $0.category == category }
    }
    
    static func generateRound() -> PickRound {
        // Выбираем случайную категорию для большой картинки
        let mainCategory = PickCategory.allCases.randomElement()!
        let mainImages = images(for: mainCategory)
        
        // Выбираем случайную большую картинку из этой категории
        let mainImage = mainImages.randomElement()!
        
        // Выбираем 2 картинки из той же категории для нижних
        var sameCategoryImages = mainImages.filter { $0.id != mainImage.id }
        sameCategoryImages.shuffle()
        let twoSameCategory = Array(sameCategoryImages.prefix(2))
        
        // Выбираем 1 картинку из другой категории
        let otherCategories = PickCategory.allCases.filter { $0 != mainCategory }
        let otherCategory = otherCategories.randomElement()!
        let otherImages = images(for: otherCategory)
        let wrongImage = otherImages.randomElement()!
        
        // Создаем массив из 3 картинок (2 правильных + 1 неправильная) и перемешиваем
        var bottomImages = twoSameCategory + [wrongImage]
        bottomImages.shuffle()
        
        return PickRound(
            mainImage: mainImage,
            bottomImages: bottomImages,
            correctCategory: mainCategory,
            wrongImageId: wrongImage.id
        )
    }
}

struct PickRound {
    let mainImage: PickImage
    let bottomImages: [PickImage] // 3 картинки: 2 из той же группы, 1 из другой
    let correctCategory: PickCategory
    let wrongImageId: UUID // ID неправильной картинки
}

