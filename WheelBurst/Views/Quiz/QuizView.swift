//
//  QuizView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import SwiftUI

struct QuizView: View {
    let difficulty: QuizDifficulty
    @Environment(\.dismiss) var dismiss
    
    @State private var questions: [QuizQuestion] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var score: Int = 0
    @State private var showResult: Bool = false
    @State private var isAnswered: Bool = false
    
    var currentQuestion: QuizQuestion? {
        guard currentQuestionIndex < questions.count else { return nil }
        return questions[currentQuestionIndex]
    }
    
    var body: some View {
        ZStack {
            Image(.mainBackImg)
                .resizable()
                .ignoresSafeArea()
            
            if showResult {
                resultView
            } else if let question = currentQuestion {
                questionView(question: question)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            questions = QuizData.questions(for: difficulty).shuffled()
        }
    }
    
    private func questionView(question: QuizQuestion) -> some View {
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
                
                // Progress indicator
                Text("\(currentQuestionIndex + 1) / \(questions.count)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.black.opacity(0.3))
                    )
            }
            
            // Question
            
                
            ZStack {
                Image(.backQuestions)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(question.question)
                    .font(.system(size: 32, weight: .semibold))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
            }//.frame(width: 350, height: 150)
                               
            // Answer options
            VStack {
                ForEach(0..<question.options.count, id: \.self) { index in
                    Button {
                        if !isAnswered {
                            selectedAnswerIndex = index
                            isAnswered = true
                            
                            if index == question.correctAnswerIndex {
                                score += 1
                            }
                            
                            // Move to next question after delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                moveToNextQuestion()
                            }
                        }
                    } label: {
                        ZStack{
                            Image(.backForAnswer)
                                .resizable()
                                //.aspectRatio(contentMode: .fit)
                            HStack {
                                Text(question.options[index])
                                    .font(.system(size: 35, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                                if isAnswered {
                                    if index == question.correctAnswerIndex {
                                        Image(.good)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    } else if index == selectedAnswerIndex && index != question.correctAnswerIndex {
                                        Image(.bad)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                    }
                                }
                            }.padding()
                                .padding(.horizontal)
                        }
                        .frame(minHeight: 50)
                    }
                    .disabled(isAnswered)
                }
            }
            
            
           
        }.padding()
    }
    
    private var resultView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            Text("Quiz Complete!")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.white)
            
            Image(.winMan)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
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
    
    private func moveToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            selectedAnswerIndex = nil
            isAnswered = false
        } else {
            showResult = true
        }
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
        QuizView(difficulty: .easy)
    }
}

