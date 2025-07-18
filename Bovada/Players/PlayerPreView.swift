//
//  FeedingPreView.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import SwiftUI

struct PlayerPreView: View {
    var player: PlayerModel

    var body: some View {
        VStack (alignment: .leading) {
            HStack (alignment: .top) {
                ZStack {
                    Color.black
                    TabView {
                        if let data = player.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                }
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                VStack (alignment: .leading, spacing: 10) {
                    Text(player.name)
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                        .padding(.top)
                        .padding(.bottom, 5)
                    HStack (alignment: .top) {
                        VStack (alignment: .leading) {
                            Text("Strengths")
                                .foregroundStyle(.grayMain)
                                .font(.system(size: 12))
                                .padding(.bottom, 5)
                            Text(player.strengths)
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .lineLimit(3)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        VStack (alignment: .leading) {
                            Text("Weaknesses")
                                .foregroundStyle(.grayMain)
                                .font(.system(size: 12))
                                .padding(.bottom, 5)
                            Text(player.weaknesses)
                                .foregroundStyle(.white)
                                .font(.system(size: 14))
                                .lineLimit(3)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack (alignment: .leading) {
                        Text("Strategy")
                            .foregroundStyle(.grayMain)
                            .font(.system(size: 12))
                            .padding(.bottom, 5)
                        Text(player.suggestedTactics)
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .lineLimit(3)
                    }
                    NavigationLink {
                        EditPlayerView(player: player)
                    } label: {
                        Text("Details")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.redMain)
                            )
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .darkFramed()
    }
}

#Preview {
    PlayerPreView(player: PlayerModel(name: "serga", strengths: "asasdfa sdfasdfa sdfasdfa sdfasfd", weaknesses: "asfadsfasdf", suggestedTactics: "asdfasdfasdf"))
        .environmentObject(UserService())
}
