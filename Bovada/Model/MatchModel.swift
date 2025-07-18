//
//  MatchModel.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import Foundation

struct MatchModel: Identifiable, Codable {
    var id: UUID = UUID()
    var opponent: PlayerModel?
    var date: Date = .now
    var location: CourtModel?
    var sets: [SetModel] = [SetModel()]
    var isWin: Bool = true
    var notes: String = ""
}

struct SetModel: Identifiable, Codable {
    var id: UUID = UUID()
    var score1: Int = 0
    var score2: Int = 0
}
