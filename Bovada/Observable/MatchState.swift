//
//  MatchState.swift
//  Bovada
//
//  Created by Кирилл Архипов on 17.07.2025.
//

import Foundation

class MatchState: ObservableObject {
    @Published var player1Points: Int = 0
    @Published var player2Points: Int = 0
    @Published var player1Games: Int = 0
    @Published var player2Games: Int = 0
    @Published var player1Sets: Int = 0
    @Published var player2Sets: Int = 0
    @Published var winner: Int? = nil

    @Published var isDeuce: Bool = false
    @Published var advantageForPlayer1: Bool?

    @Published var isPaused: Bool = false
    @Published var isFinished: Bool = false

    func player1Scored() {
        guard !isPaused && !isFinished else { return }

        if isDeuce {
            if advantageForPlayer1 == true {
                winGame(forPlayer1: true)
            } else if advantageForPlayer1 == nil {
                advantageForPlayer1 = true
            } else {
                advantageForPlayer1 = nil
            }
        } else {
            addPoint(toPlayer1: true)
        }
    }

    func player2Scored() {
        guard !isPaused && !isFinished else { return }

        if isDeuce {
            if advantageForPlayer1 == false {
                winGame(forPlayer1: false)
            } else if advantageForPlayer1 == nil {
                advantageForPlayer1 = false
            } else {
                advantageForPlayer1 = nil
            }
        } else {
            addPoint(toPlayer1: false)
        }
    }

    func addPoint(toPlayer1: Bool) {
        var points = toPlayer1 ? player1Points : player2Points
        let opponentPoints = toPlayer1 ? player2Points : player1Points

        switch points {
        case 0: points = 15
        case 15: points = 30
        case 30: points = 40
        case 40:
            if opponentPoints < 40 {
                winGame(forPlayer1: toPlayer1)
                return
            } else {
                isDeuce = true
                advantageForPlayer1 = toPlayer1 ? true : false
                return
            }
        default: break
        }

        if toPlayer1 {
            player1Points = points
        } else {
            player2Points = points
        }
    }

    func winGame(forPlayer1: Bool) {
        if forPlayer1 {
            player1Games += 1
        } else {
            player2Games += 1
        }

        if (player1Games >= 6 || player2Games >= 6) &&
            abs(player1Games - player2Games) >= 2 {

            if player1Games > player2Games {
                player1Sets += 1
            } else {
                player2Sets += 1
            }

            player1Games = 0
            player2Games = 0
        }

        player1Points = 0
        player2Points = 0
        isDeuce = false
        advantageForPlayer1 = nil
    }

    func togglePause() {
        isPaused.toggle()
    }

    func endMatch() {
        if player1Sets > player2Sets {
            winner = 1
            isFinished = true
        } else if player1Sets < player2Sets {
            winner = 2
            isFinished = true
        } else {
            if player1Games > player2Games {
                winner = 1
                isFinished = true
            } else if player1Games < player2Games {
                winner = 2
                isFinished = true
            } else {
                if player1Points > player2Points {
                    winner = 1
                    isFinished = true
                } else if player1Points < player2Points {
                    winner = 2
                    isFinished = true
                } else {
                    winner = nil
                    isFinished = true
                }
            }
        }
    }

    func resetMatch() {
        player1Points = 0
        player2Points = 0
        player1Games = 0
        player2Games = 0
        player1Sets = 0
        player2Sets = 0
        winner = nil
        isDeuce = false
        advantageForPlayer1 = nil
        isPaused = false
        isFinished = false
    }

}
