//
//  RecipeModel.swift
//  ChickenRoad
//
//  Created by Кирилл Архипов on 27.06.2025.
//

import Foundation
import SwiftUI

struct CourtModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String = ""
    var location: String = ""
    var type: CourtType = .hard
    var setting: CourtSetting = .outdoor
    var imageData1: Data?
    var imageData2: Data?
    var imageData3: Data?

    var convenience: Double = 0
    var condition: Double = 0
    var lighting: Double = 0
    var amenities: Double = 0
    var overallRating: Int {
        Int((convenience + condition + lighting + amenities) / 4)
    }

    var comments: String = ""
}

enum CourtType: String, CaseIterable, Codable {
    case hard = "Hard"
    case clay = "Clay"
    case grass = "Grass"
    case carpet = "Carpet"
    case other = "Other"
}

enum CourtSetting: String, CaseIterable, Codable {
    case outdoor = "Outdoor"
    case indoor = "Indoor"
}
