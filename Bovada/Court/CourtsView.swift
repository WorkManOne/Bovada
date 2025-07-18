//
//  CourtsView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct CourtsView: View {
    @EnvironmentObject var userService: UserService

    var body: some View {
        ZStack {
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Courts")
                        .foregroundStyle(.white)
                        .font(.system(size: 24))
                        .padding(.bottom, 5)
                    Text("Rate tennis courts")
                        .foregroundStyle(.grayMain)
                        .font(.system(size: 14))
                        .padding(.bottom, 30)
                    LazyVStack(spacing: 10) {
                        Text("Your courts")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ForEach(userService.courts) { court in
                            NavigationLink {
                                EditCourtView(court: court)
                            } label: {
                                CourtPreView(court: court)
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
                        EditCourtView()
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
    CourtsView()
        .environmentObject(UserService())
}
