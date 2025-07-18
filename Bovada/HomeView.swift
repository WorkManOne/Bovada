//
//  HomeView.swift
//  Dafabet
//
//  Created by Кирилл Архипов on 11.07.2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userService: UserService
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                Text("TennisTracker")
                    .foregroundStyle(.white)
                    .font(.system(size: 24))
                    .padding(.bottom, 5)
                Text("Welcome back!")
                    .foregroundStyle(.grayMain)
                    .font(.system(size: 14))
                    .padding(.bottom)
                HStack (spacing: 15) {
                    NavigationLink {
                        EditMatchView()
                    } label: {
                        VStack {
                            Image(systemName: "plus")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(.bottom, 10)
                            Text("New Match")
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                        }
                        .padding(.vertical)
                        .colorFramed(color: .redMain)
                    }
                    NavigationLink {
                        UmpireView()
                    } label: {
                        VStack {
                            Image("whistle")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .padding(.bottom, 10)
                            Text("Umpire Mode")
                                .foregroundStyle(.white)
                                .font(.system(size: 16))
                        }
                        .padding(.vertical)
                        .darkFramed()
                    }
                }
                .padding(.bottom)
                VStack {
                    HStack {
                        Text("Latest Match")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    if let lastMatch = userService.matches.findLast {
                        MatchPreView(match: lastMatch)
                    }
                }
                .padding(.bottom)
                VStack {
                    HStack {
                        Text("Your Stats")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    HStack (spacing: 15) {
                        VStack {
                            Text("\(userService.matches.count)")
                                .font(.system(size: 24))
                                .foregroundStyle(.redMain)
                                .multilineTextAlignment(.center)
                            Text("Matches Played")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 60)
                        .darkFramed()
                        VStack {
                            Text("\(userService.matches.count(where: {$0.isWin}))")
                                .font(.system(size: 24))
                                .foregroundStyle(.redMain)
                                .multilineTextAlignment(.center)
                            Text("Wins")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 60)
                        .darkFramed()
                        VStack {
                            Text("\(Int(Double(userService.matches.count(where: {$0.isWin})) / Double(userService.matches.count == 0 ? 1 : userService.matches.count) * 100))%")
                                .font(.system(size: 24))
                                .foregroundStyle(.redMain)
                                .multilineTextAlignment(.center)
                            Text("Win Rate")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                                .multilineTextAlignment(.center)
                        }
                        .frame(height: 60)
                        .darkFramed()
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 80)
            .padding(.bottom, getSafeAreaBottom())
        }
        .background(.backgroundMain)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")

    }
}

#Preview {
    HomeView()
        .environmentObject(UserService())
}
