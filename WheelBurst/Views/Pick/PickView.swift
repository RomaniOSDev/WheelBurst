//
//  PickView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import SwiftUI

struct PickView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var currentRound: PickRound?
    @State private var selectedImageId: UUID?
    @State private var isAnswered: Bool = false
    @State private var score: Int = 0
    @State private var roundNumber: Int = 1
    @State private var showResult: Bool = false
    @State private var isCorrect: Bool = false
    @State private var timeRemaining: Int = 15
    @State private var timer: Timer?
    
    private let totalRounds: Int = 10
    private let roundTimeLimit: Int = 15
    
    var body: some View {
        ZStack {
            Image(.mainBackImg)
                .resizable()
                .ignoresSafeArea()
            
            if showResult {
                resultView
            } else if let round = currentRound {
                gameView(round: round)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            startNewRound()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    private func gameView(round: PickRound) -> some View {
        VStack {
            // Header
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.backBTN)
                        .resizable()
                        .frame(width: 85, height: 76)
                }
                Spacer()
                
                // Таймер
                Text("\(timeRemaining)s")
                    .font(.system(size: 40, weight: .heavy, design: .monospaced))
                    .foregroundColor(timeRemaining <= 5 ? .red : .white)
                    .padding(.top, 5)
            
            Spacer()
                Image(.backBTN)
                    .resizable()
                    .frame(width: 85, height: 76)
                    .opacity(0)
            
            }
            
            // Score and round
            VStack(spacing: 5) {
                Text("Round \(roundNumber)/\(totalRounds)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                Text("Find the odd one out")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
               
            }
            
            Spacer()
            
            // Большая картинка сверху
           
                
                // Изображение из Assets
                Image(round.mainImage.imageName)
                    .resizable()
                    .frame(width: 170, height: 170)
            
           
            
           Spacer()
            
            // 3 маленькие картинки внизу (треугольное расположение: 2 сверху, 1 снизу)
            VStack(spacing: 20) {
                // Две картинки сверху
                HStack(spacing: 20) {
                    ForEach(Array(round.bottomImages.prefix(2))) { image in
                        imageButton(for: image, round: round)
                    }
                }
                
                // Одна картинка снизу по центру
                imageButton(for: round.bottomImages[2], round: round)
            }
            Spacer()
            
        }
        .padding()
    }
    
    private var resultView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            Image(.winMan)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Game Complete!")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
            
            Text("Final Score: \(score) / \(totalRounds)")
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(.white)
            
            let percentage = Double(score) / Double(totalRounds) * 100
            Text("\(Int(percentage))%")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(percentageColor(percentage))
            
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
    
    private func imageButton(for image: PickImage, round: PickRound) -> some View {
        Button {
            if !isAnswered {
                selectImage(image.id, isCorrect: image.id == round.wrongImageId)
            }
        } label: {
            ZStack{
                // Изображение из Assets
                Image(image.imageName)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .opacity(isAnswered && image.id != round.wrongImageId && selectedImageId != image.id ? 0.5 : 1.0)
                
                // Индикатор правильности/неправильности
                if isAnswered {
                    if image.id == round.wrongImageId {
                        // Правильный ответ (всегда показываем правильный)
                        Image(.good)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(x: 50, y: -50)
                    } else if selectedImageId == image.id && image.id != round.wrongImageId {
                        // Неправильный ответ (выбранная неправильная картинка или время истекло)
                        Image(.bad)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .offset(x: 50, y: -50)
                    }
                }
            }
        }
        .disabled(isAnswered)
    }
    
    private func selectImage(_ imageId: UUID, isCorrect: Bool) {
        // Останавливаем таймер при ответе
        stopTimer()
        
        selectedImageId = imageId
        isAnswered = true
        self.isCorrect = isCorrect
        
        if isCorrect {
            score += 1
        }
        
        // Переход к следующему раунду через 1.5 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if roundNumber < totalRounds {
                roundNumber += 1
                startNewRound()
            } else {
                showResult = true
            }
        }
    }
    
    private func startNewRound() {
        // Останавливаем предыдущий таймер, если он есть
        stopTimer()
        
        currentRound = PickGameData.generateRound()
        selectedImageId = nil
        isAnswered = false
        isCorrect = false
        timeRemaining = roundTimeLimit
        
        // Запускаем новый таймер
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                // Время истекло - ответ считается неправильным
                self.stopTimer()
                self.isAnswered = true
                self.isCorrect = false
                
                // Выбираем случайную неправильную картинку для визуализации
                if let round = self.currentRound {
                    let wrongImages = round.bottomImages.filter { $0.id != round.wrongImageId }
                    if let randomWrong = wrongImages.randomElement() {
                        self.selectedImageId = randomWrong.id
                    }
                }
                
                // Очки не добавляются (isCorrect = false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if self.roundNumber < self.totalRounds {
                        self.roundNumber += 1
                        self.startNewRound()
                    } else {
                        self.showResult = true
                    }
                }
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func percentageColor(_ percentage: Double) -> Color {
        if percentage >= 80 {
            return .green
        } else if percentage >= 60 {
            return .yellow
        } else {
            return .red
        }
    }
}

#Preview {
    NavigationStack {
        PickView()
    }
}
