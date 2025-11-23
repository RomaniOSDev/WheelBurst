//
//  OnBoard.swift
//  WheelBurst
//
//  Created by Роман Главацкий on 19.11.2025.
//

import SwiftUI

struct OnBoard: View {
    @AppStorage("isfirstlaunch") var isFirstLaunch: Bool = true
    var body: some View {
        Button("slip") {
            isFirstLaunch = false
        }
    }
}

#Preview {
    OnBoard()
}
