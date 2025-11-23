//
//  ChooseLevelForMatchView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 20.11.2025.
//

import SwiftUI

struct ChooseLevelForMatchView: View {
    @Environment(\.dismiss) var dismiss
    @State private var completedLevels: Set<Int> = Set(MatchLevelManager.getCompletedLevels())
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
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
                .padding()
                
                Spacer()
                
                // Level selection grid
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(MatchLevel.allLevels) { level in
                        NavigationLink {
                            MatchView(level: level)
                                .onDisappear {
                                    // Обновляем список пройденных уровней при возврате
                                    completedLevels = Set(MatchLevelManager.getCompletedLevels())
                                }
                        } label: {
                            VStack(spacing: 5) {
                                Text("\(level.id)")
                                    .font(.system(size: 36, weight: .bold))
                                    .foregroundColor(.white)
                                
                                Text("\(level.timeLimit)s")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.white.opacity(0.7))
                            }
                            .frame(width: 90, height: 90)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color(.backLevel))
                                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                            )
                            .opacity(completedLevels.contains(level.id) ? 0.5 : 1.0)
                        }
                        
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            completedLevels = Set(MatchLevelManager.getCompletedLevels())
        }
    }
    
    private func levelColor(for levelId: Int) -> Color {
        if levelId <= 3 {
            return Color.green.opacity(0.7)
        } else if levelId <= 6 {
            return Color.orange.opacity(0.7)
        } else {
            return Color.red.opacity(0.7)
        }
    }
}

#Preview {
    ChooseLevelForMatchView()
}
