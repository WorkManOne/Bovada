//
//  MatchesView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct MatchesView: View {
    @EnvironmentObject var userService: UserService

    var groupedMatches: [(key: Date, value: [MatchModel])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: userService.matches) { match in
            let components = calendar.dateComponents([.year, .month], from: match.date)
            return calendar.date(from: components)!
        }
        return grouped.sorted { $0.key > $1.key }
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Match History")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                    Text("Your past matches")
                        .foregroundStyle(.grayMain)
                        .font(.system(size: 14))
                    HStack {
                        VStack {
                            Text("\(userService.matches.count)")
                                .font(.system(size: 20))
                                .foregroundStyle(.white)
                            Text("Total Matches")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("\(userService.matches.count(where: {$0.isWin}))")
                                .font(.system(size: 20))
                                .foregroundStyle(.green)
                            Text("Wins")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                        }
                        .frame(maxWidth: .infinity)
                        VStack {
                            Text("\(userService.matches.count(where: {!$0.isWin}))")
                                .font(.system(size: 20))
                                .foregroundStyle(.red)
                            Text("Losses")
                                .font(.system(size: 12))
                                .foregroundStyle(.grayMain)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .darkFramed()
                    .padding(.top, 15)
                    .padding(.bottom, 30)
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(groupedMatches, id: \.key) { (date, matches) in
                            Text(dateFormatter.string(from: date))
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            ForEach(matches) { match in
                                MatchPreView(match: match)
                            }
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
                        EditMatchView()
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
    MatchesView()
        .environmentObject(UserService())
}
