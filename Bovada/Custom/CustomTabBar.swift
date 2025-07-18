//
//  CustomTabBar.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import SwiftUI



struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer()
            TabBarButton(icon: Image("home"), title: "Home", index: 0, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("matches"), title: "Matches", index: 1, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("players"), title: "Players", index: 2, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("courts"), title: "Courts", index: 3, selectedTab: $selectedTab)
            Spacer()
            TabBarButton(icon: Image("settings"), title: "Settings", index: 4, selectedTab: $selectedTab)
            Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, getSafeAreaBottom()+8)
        .background(
            Color(.darkFrame)
                .clipShape(RoundedCorners(radius: 30, corners: [.topLeft, .topRight]))
        )
        .ignoresSafeArea(edges: .bottom)
    }
}

struct TabBarButton: View {
    let icon: Image
    let title: String
    let index: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = index
        }) {
            VStack(spacing: 4) {
                icon
                    .renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text(title)
                    .font(.system(size: 12))
            }
            .foregroundColor(selectedTab == index ? .redMain : .grayMain)
        }
    }
}

#Preview {
    CustomTabBar(selectedTab: .constant(0))
        .ignoresSafeArea()
        .background(.black)
}
