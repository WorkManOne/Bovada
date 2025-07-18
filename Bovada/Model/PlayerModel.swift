//
//  FeedingModel.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import Foundation
import SwiftUI

struct PlayerModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var contact: String = ""
    var strengths: String = ""
    var weaknesses: String = ""
    var suggestedTactics: String = ""
    var imageData: Data?
}
