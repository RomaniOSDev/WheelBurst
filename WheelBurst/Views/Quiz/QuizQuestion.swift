//
//  QuizQuestion.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import Foundation

enum QuizDifficulty: String, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    
    var emoji: String {
        switch self {
        case .easy: return "🌟"
        case .medium: return "⭐"
        case .hard: return "💥"
        }
    }
    
    var imageLabel: ImageResource{
        switch self {
        case .easy: return .easyLabel
        case .medium: return .medium
        case .hard: return .hardLabel
        }
    }
}

struct QuizQuestion: Identifiable {
    let id = UUID()
    let question: String
    let options: [String]
    let correctAnswerIndex: Int
    let difficulty: QuizDifficulty
    
    var correctAnswer: String {
        options[correctAnswerIndex]
    }
}

struct QuizData {
    static let allQuestions: [QuizQuestion] = [
        // EASY - Questions 1-10
        QuizQuestion(question: "What color is a banana?", options: ["Red", "Yellow", "Blue"], correctAnswerIndex: 1, difficulty: .easy),
        QuizQuestion(question: "Who says \"meow\"?", options: ["Cow", "Cat", "Horse"], correctAnswerIndex: 1, difficulty: .easy),
        QuizQuestion(question: "What can swim?", options: ["Fish", "Cat", "Mouse"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "What color is grass?", options: ["Green", "Black", "Pink"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "What drives on the road?", options: ["Car", "Cloud", "Table"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "Who likes carrots?", options: ["Rabbit", "Tiger", "Crocodile"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "What grows on a tree?", options: ["Apple", "Ball", "Chair"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "Who can fly?", options: ["Elephant", "Bird", "Dog"], correctAnswerIndex: 1, difficulty: .easy),
        QuizQuestion(question: "What color is an orange?", options: ["Orange", "Blue", "White"], correctAnswerIndex: 0, difficulty: .easy),
        QuizQuestion(question: "What do we drink?", options: ["Water", "Sand", "Star"], correctAnswerIndex: 0, difficulty: .easy),
        
        // MEDIUM - Questions 11-20
        QuizQuestion(question: "Who has a shell?", options: ["Snail", "Dog", "Bear"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "What is prickly?", options: ["Hedgehog", "Rabbit", "Fox"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "Who lives in the sea?", options: ["Ball", "Shark", "Cow"], correctAnswerIndex: 1, difficulty: .medium),
        QuizQuestion(question: "What shows time?", options: ["Clock", "Glasses", "Book"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "Which fruit is red?", options: ["Watermelon", "Banana", "Coconut"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "What can you spread on bread?", options: ["Jam", "Pencil", "Rock"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "Who loves honey?", options: ["Squirrel", "Bear", "Lion"], correctAnswerIndex: 1, difficulty: .medium),
        QuizQuestion(question: "What do we use for writing?", options: ["Pen", "Bucket", "Hat"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "Who jumps in puddles?", options: ["Frog", "Deer", "Owl"], correctAnswerIndex: 0, difficulty: .medium),
        QuizQuestion(question: "Which item is soft?", options: ["Pillow", "Scissors", "Brick"], correctAnswerIndex: 0, difficulty: .medium),
        
        // HARD - Questions 21-30
        QuizQuestion(question: "Which bird is awake at night?", options: ["Owl", "Goose", "Rooster"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What is a baby cow called?", options: ["Calf", "Puppy", "Kitten"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What melts in the sun?", options: ["Ice", "Paper", "Leaf"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What shows direction?", options: ["Compass", "Pencil", "Plate"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "Who lives in Australia?", options: ["Kangaroo", "Penguin", "Camel"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What can be transparent?", options: ["Glass", "Cube", "Leaf"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "Who builds dams?", options: ["Beaver", "Fox", "Wolf"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What helps us see in the dark?", options: ["Flashlight", "Spoon", "Book"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "What grows the fastest?", options: ["Grass", "Stones", "Pencils"], correctAnswerIndex: 0, difficulty: .hard),
        QuizQuestion(question: "Who lives in a pack?", options: ["Wolves", "Bears", "Snails"], correctAnswerIndex: 0, difficulty: .hard)
    ]
    
    static func questions(for difficulty: QuizDifficulty) -> [QuizQuestion] {
        allQuestions.filter { $0.difficulty == difficulty }
    }
}

