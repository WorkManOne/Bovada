//
//  MatchPreView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct MatchPreView: View {
    @EnvironmentObject var userService: UserService
    var match: MatchModel

    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(match.date.formatted(date: .abbreviated, time: .omitted))
                    .foregroundStyle(.grayMain)
                    .font(.system(size: 12))
                Spacer()
                Text(match.isWin ? "Win" : "Loss")
                    .foregroundStyle(.white)
                    .font(.system(size: 12))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(match.isWin ? .green : .red)
                    )
            }
            .padding(.bottom, 5)
            HStack (alignment: .top) {
                VStack {
                    ZStack {
                        Color.black
                        if let data = userService.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    Text("You")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
                Spacer()
                VStack {
                    ForEach (match.sets, id: \.id) { set in
                        Text("\(set.score1):\(set.score2)")
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .minimumScaleFactor(0.2)
                    }
                }
                Spacer()
                VStack {
                    ZStack {
                        Color.black
                        if let opponent = match.opponent, let data = opponent.imageData, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        }
                    }
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    Text(match.opponent?.name ?? "")
                        .foregroundStyle(.white)
                        .font(.system(size: 16))
                }
            }
            HStack {
                Image("location")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.grayMain)
                    .frame(width: 12, height: 12)
                Text(match.location?.name ?? "")
                    .foregroundStyle(.grayMain)
                    .font(.system(size: 12))
                Spacer()
                NavigationLink {
                    EditMatchView(match: match)
                } label: {
                    Text("Details")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.redMain)
                        )
                }
            }
        }
        .darkFramed()
    }
}

#Preview {
    MatchPreView(match: MatchModel())
}
