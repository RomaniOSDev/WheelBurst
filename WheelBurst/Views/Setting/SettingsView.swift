//
//  SettingsView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var policy: String = "https://www.termsfeed.com/live/7a665630-9f2a-43e7-b494-a7adbd3eb902"
    
    var body: some View {
        ZStack{
            Image(.mainBackImg)
                .resizable().ignoresSafeArea()
            VStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image(.backBTN)
                            .resizable()
                            .frame(width: 85, height: 76)
                    }
                    Spacer()

                }
                Image(.settingsLabel)
                    .resizable()
                    .frame(width: 213, height: 107)
                Spacer()
                VStack(spacing: 30){
                    Button {
                        SKStoreReviewController.requestReview()
                    } label: {
                        Image(.rateUpBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    Button {
                        if let url = URL(string: policy) {
                            UIApplication.shared.open(url)
                        }
                    } label: {
                        Image(.policyBTN)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }

                
                Spacer()
            }.padding()
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
