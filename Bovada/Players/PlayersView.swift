//
//  PlayersView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct PlayersView: View {
    @EnvironmentObject var userService: UserService

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Players")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                    Text("Remember your opponents")
                        .foregroundStyle(.grayMain)
                        .font(.system(size: 14))
                        .padding(.bottom, 30)
                    LazyVStack(spacing: 10) {
                        ForEach(userService.players) { player in
                            PlayerPreView(player: player)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 80)
                .padding(.bottom, getSafeAreaBottom())
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink {
                        EditPlayerView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .padding(20)
                            .background(
                                Circle()
                                    .fill(.redMain)
                            )
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 80)
                    .padding(.bottom, getSafeAreaBottom())
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .background(.backgroundMain)
    }

}

#Preview {
    PlayersView()
        .environmentObject(UserService())
}
