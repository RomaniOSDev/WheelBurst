//
//  ChooseLevelForQuizView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import SwiftUI

struct ChooseLevelForQuizView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                Image(.mainBackImg)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack {
                    // Back button
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(.backBTN)
                                .resizable()
                                .frame(width: 85, height: 76)
                        }
                        Spacer()
                    }
                    
                    // Difficulty selection buttons
                    ZStack(alignment: .top) {
                        Image(.dictor)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                        VStack {
                            Spacer()
                            ForEach(QuizDifficulty.allCases, id: \.self) { difficulty in
                                NavigationLink {
                                    QuizView(difficulty: difficulty)
                                } label: {
                                    Image(difficulty.imageLabel)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                }.padding()
            }
            .navigationBarBackButtonHidden()
        
    }
    
    private func difficultyColors(for difficulty: QuizDifficulty) -> [Color] {
        switch difficulty {
        case .easy:
            return [Color.green.opacity(0.8), Color.green.opacity(0.6)]
        case .medium:
            return [Color.orange.opacity(0.8), Color.orange.opacity(0.6)]
        case .hard:
            return [Color.red.opacity(0.8), Color.red.opacity(0.6)]
        }
    }
}

#Preview {
    ChooseLevelForQuizView()
}
