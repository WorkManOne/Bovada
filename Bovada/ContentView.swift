//
//  ContentView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                TabView (selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                    MatchesView()
                        .tag(1)
                    PlayersView()
                        .tag(2)
                    CourtsView()
                        .tag(3)
                    SettingsView()
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
