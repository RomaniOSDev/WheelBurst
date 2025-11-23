//
//  GameListView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI

struct GameListView: View {
    var body: some View {
        ZStack{
            Image(.mainBackImg)
                .resizable().ignoresSafeArea()
            VStack{
                Spacer()
                //Quiz
                NavigationLink {
                    ChooseLevelForQuizView()
                } label: {
                    Image(.burstQuizLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //MAtch
                NavigationLink {
                    ChooseLevelForMatchView()
                } label: {
                    Image(.burstMatchLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
                //Pick
                NavigationLink {
                    PickView()
                } label: {
                    Image(.burstPickLabel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                Spacer()

            }.padding()
        }
    }
}

#Preview {
    GameListView()
}
