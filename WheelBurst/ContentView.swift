//
//  ContentView.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("isfirstlaunch") var isFirstLaunch: Bool = true
    var body: some View {
        if isFirstLaunch {
            OnBoard()
        }else {
            StartView()
        }
    }
}

#Preview {
    ContentView()
}
