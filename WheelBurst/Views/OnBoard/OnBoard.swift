//
//  OnBoard.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI

struct OnBoard: View {
    @AppStorage("isfirstlaunch") var isFirstLaunch: Bool = true
    @State private var currentPage: Int = 0
    
    var body: some View {
        ZStack {
            Image(.mainBackImg)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // TabView для страниц онбординга
                TabView(selection: $currentPage) {
                    OnBoardPage(
                        title: "Welcome!",
                        description: "Learn new words and develop memory with exciting games",
                        pageIndex: 0
                    )
                    .tag(0)
                    
                    OnBoardPage(
                        title: "Three Games in One",
                        description: "Quiz, Memory and Pick - choose your favorite game and start learning",
                        pageIndex: 1
                    )
                    .tag(1)
                    
                    OnBoardPage(
                        title: "Start Playing",
                        description: "Choose your difficulty level and start your journey to new knowledge",
                        pageIndex: 2
                    )
                    .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                // Индикаторы страниц
                HStack(spacing: 12) {
                    ForEach(0..<3) { index in
                        Circle()
                            .fill(index == currentPage ? Color.yellow : Color.gray.opacity(0.5))
                            .frame(width: 12, height: 12)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                .padding(.bottom, 30)
                
                // Кнопка навигации
                Button(action: {
                    if currentPage < 2 {
                        withAnimation {
                            currentPage += 1
                        }
                    } else {
                        isFirstLaunch = false
                    }
                }) {
                    Text(currentPage < 2 ? "Next" : "Get Started")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.yellow)
                        .cornerRadius(12)
                        .shadow(color: .yellow.opacity(0.5), radius: 10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
            }
        }
    }
}

struct OnBoardPage: View {
    let title: String
    let description: String
    let pageIndex: Int
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Иконка или изображение для страницы
            Image(.logoWheel)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .shadow(color: .yellow, radius: 20)
            
            VStack(spacing: 20) {
                Text(title)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: .black.opacity(0.3), radius: 5)
                
                Text(description)
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .shadow(color: .black.opacity(0.3), radius: 5)
            }
            
            Spacer()
        }
    }
}

#Preview {
    OnBoard()
}
