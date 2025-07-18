//
//  ArrayExtension.swift
//  Bovada
//
//  Created by Кирилл Архипов on 16.07.2025.
//

import Foundation

extension Array where Element == MatchModel {
    var findLast: MatchModel? {
        self
            .filter { $0.date < Date() }
            .max(by: { $0.date < $1.date })
    }
}
