//
//  BovadaApp.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

@main
struct BovadaApp: App {
    @ObservedObject var userService = UserService()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userService)
                .preferredColorScheme(.dark)
                .fullScreenCover(isPresented: .constant(userService.isFirstLaunch)) {
                    OnboardingView()
                        .environmentObject(userService)
                }
        }
    }
}
