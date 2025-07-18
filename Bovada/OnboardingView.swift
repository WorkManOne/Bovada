//
//  OnboardingView.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var userService: UserService
    @State private var selectedIndex = 0

    var body: some View {
        VStack {
            Spacer()
            Image("tennis")
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding(30)
                .background(
                    Circle()
                        .fill(.redMain)
                )
            Text("Welcome to TennisTracker")
                .foregroundStyle(.white)
                .font(.system(size: 30))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.vertical)
            Text("Your ultimate tennis companion for tracking matches, analyzing opponents, and improving your game")
                .foregroundStyle(.grayMain)
                .font(.system(size: 18))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Spacer()
            Button {
                userService.isFirstLaunch = false
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundStyle(.white)
                    .font(.system(size: 30))
                    .padding(20)
                    .background(
                        Circle()
                            .fill(.redMain)
                    )
            }
            .padding(.bottom, 30)
        }
        .background(.backgroundMain)
    }
}

#Preview {
    OnboardingView()
        .background(.black)
        .environmentObject(UserService())
}
