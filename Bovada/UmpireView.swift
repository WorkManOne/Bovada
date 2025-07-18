//
//  UmpireView.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import SwiftUI

struct UmpireView: View {
    @EnvironmentObject var userService: UserService
    @ObservedObject var matchState: MatchState = MatchState()
    @Environment(\.dismiss) var dismiss

    @State private var timerSeconds = 75
    @State private var timerRunning = false
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)
                    }
                    Text("Umpire Mode")
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                }
                HStack {
                    VStack (spacing: 5) {
                        Text("SETS")
                            .font(.system(size: 12))
                            .foregroundStyle(.grayMain)
                        Text("\(matchState.player1Sets) : \(matchState.player2Sets)")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)

                    }
                    .frame(maxWidth: .infinity)
                    VStack (spacing: 5) {
                        Text("GAMES")
                            .font(.system(size: 12))
                            .foregroundStyle(.grayMain)
                        Text("\(matchState.player1Games) : \(matchState.player2Games)")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)

                    }
                    .frame(maxWidth: .infinity)
                    VStack (spacing: 5) {
                        Text("POINTS")
                            .font(.system(size: 12))
                            .foregroundStyle(.grayMain)
                        Text("\(matchState.player1Points) : \(matchState.player2Points)")
                            .font(.system(size: 20))
                            .foregroundStyle(.white)

                    }
                    .frame(maxWidth: .infinity)
                }
                .darkFramed()
                .padding(.top, 15)
                HStack {
                    Button {
                        matchState.player1Scored()
                    } label: {
                        VStack (spacing: 10) {
                            Text("Player 1")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            Text("Scores Point")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                        .darkFramed()
                    }

                    Button {
                        matchState.player2Scored()
                    } label: {
                        VStack (spacing: 10) {
                            Text("Player 2")
                                .font(.system(size: 18))
                                .foregroundStyle(.white)
                            Text("Scores Point")
                                .font(.system(size: 14))
                                .foregroundStyle(.white)
                        }
                        .padding(.vertical)
                        .darkFramed()
                    }
                }
                HStack {
                    VStack (alignment: .leading) {
                        Text("Change Sides")
                            .font(.system(size: 16))
                            .foregroundStyle(.white)
                            .padding(.bottom, 5)
                        Text("After odd games")
                            .font(.system(size: 14))
                            .foregroundStyle(.grayMain)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(.backgroundMain)
                            .frame(width: 80, height: 80)
                        Circle()
                            .trim(from: 1 - CGFloat(timerSeconds) / 75.0, to: 1)
                            .stroke(
                                timerRunning ? Color.redMain : Color.grayMain,
                                style: StrokeStyle(lineWidth: 3, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 1), value: timerSeconds)
                            .frame(width: 80, height: 80)
                        Text("\(timerSeconds)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(.white)
                    }
                    Button {
                        timerRunning = true
                        timerSeconds = 75
                    } label: {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                            Text("Start")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.redMain)
                        )
                    }
                }
                .darkFramed()
                HStack {
                    Button {
                        withAnimation {
                            matchState.togglePause()
                        }
                    } label: {
                        HStack {
                            if matchState.isPaused {
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                    .frame(height: 16)
                            } else {
                                Image("pause")
                                    .resizable()
                                    .renderingMode(.template)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundStyle(.white)
                                    .frame(height: 16)
                            }
                            Text(matchState.isPaused ? "Resume Match" : "Pause Match")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                        .darkFramed()
                    }
                    Button {
                        withAnimation {
                            matchState.endMatch()
                        }
                    } label: {
                        HStack {
                            Image("finish")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundStyle(.white)
                                .frame(height: 16)
                            Text("End Match")
                                .font(.system(size: 16))
                                .foregroundStyle(.white)
                        }
                        .colorFramed(color: .redMain)
                    }
                }


            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
        .background(.backgroundMain)
        .onAppear {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first,
               let nav = window.rootViewController?.children.first as? UINavigationController {
                nav.interactivePopGestureRecognizer?.isEnabled = true
                nav.interactivePopGestureRecognizer?.delegate = nil
            }
        }
        .alert("Match Finished", isPresented: $matchState.isFinished) {
            Button("OK", role: .cancel) {
                matchState.resetMatch()
            }
        } message: {
            Text(matchState.winner == nil ? "Draw" : "Player \(matchState.winner ?? 0) won the match!")
        }
        .onReceive(timer) { _ in
            guard timerRunning else { return }
            if timerSeconds > 0 {
                if !matchState.isPaused {
                    timerSeconds -= 1
                    if userService.isVibration {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                }
            } else {
                if userService.isVibration {
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.prepare()
                    generator.impactOccurred()
                }
                timerRunning = false
            }
        }
    }
}

#Preview {
    UmpireView()
        .environmentObject(UserService())
}
