//
//  StartView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI

struct StartView: View {
    @State private var scaleFrameToStartBTN: Bool = false
    var body: some View {
        NavigationStack {
            ZStack{
                Image(.mainBackImg)
                    .resizable().ignoresSafeArea()
                VStack{
                   //Top bar
                    HStack{
                        Spacer()
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(.settingImg)
                                .resizable()
                                .frame(width: 67, height: 67)
                        }

                    }
                    Image(.logoWheel)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: .yellow, radius: !scaleFrameToStartBTN ? 10 : 2)
                    
                    Spacer()
                    
                    NavigationLink {
                        GameListView()
                    } label: {
                        Image(.startBtm)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: scaleFrameToStartBTN ? 130 : 100)
                            .shadow(color: .yellow, radius: scaleFrameToStartBTN ? 10 : 2)
                    }

                }.padding()
            }
            .animation(.easeInOut, value: scaleFrameToStartBTN)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { Timer in
                    scaleFrameToStartBTN.toggle()
                }
            }
        }
    }
}

#Preview {
    StartView()
}
