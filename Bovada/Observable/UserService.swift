//
//  UserDataModel.swift
//  ProMatch
//
//  Created by Кирилл Архипов on 23.06.2025.
//

import Foundation
import SwiftUI

class UserService: ObservableObject {
    @AppStorage("isFirstLaunch") var isFirstLaunch: Bool = true
    @AppStorage("isVibration") var isVibration: Bool = false
    @AppStorage("isNotificationEnabled") var isNotificationEnabled: Bool = false

    @Published var matches: [MatchModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(matches), forKey: "matches")
        }
    }
    @Published var players: [PlayerModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(players), forKey: "players")
        }
    }
    @Published var courts: [CourtModel] {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(courts), forKey: "courts")
        }
    }
    @Published var imageData: Data? {
        didSet {
            UserDefaults.standard.set(try? JSONEncoder().encode(imageData), forKey: "imageData")
        }
    }

    init() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: "matches"),
           let decoded = try? JSONDecoder().decode([MatchModel].self, from: data) {
            matches = decoded
        } else {
            matches = []
        }
        if let data = userDefaults.data(forKey: "players"),
           let decoded = try? JSONDecoder().decode([PlayerModel].self, from: data) {
            players = decoded
        } else {
            players = []
        }
        if let data = userDefaults.data(forKey: "courts"),
           let decoded = try? JSONDecoder().decode([CourtModel].self, from: data) {
            courts = decoded
        } else {
            courts = []
        }
        if let data = userDefaults.data(forKey: "imageData"),
           let decoded = try? JSONDecoder().decode(Data.self, from: data) {
            imageData = decoded
        } else {
            imageData = nil
        }
    }

    func reset() {
        isFirstLaunch = true
        isVibration = false
        isNotificationEnabled = false
        matches = []
        players = []
        courts = []
    }

    func removeMatches() {
        matches.removeAll()
    }

    func toggleNotifications(to newValue: Bool, onDenied: @escaping () -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .denied:
                    onDenied()
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()

                case .notDetermined:
                    NotificationManager.shared.requestPermission { granted in
                        DispatchQueue.main.async {
                            self.isNotificationEnabled = granted && newValue
                            if self.isNotificationEnabled {
                                NotificationManager.shared.scheduleNotification()
                            } else {
                                NotificationManager.shared.removeScheduledNotifications()
                            }
                        }
                    }

                case .authorized, .provisional, .ephemeral:
                    self.isNotificationEnabled = newValue
                    if newValue {
                        NotificationManager.shared.scheduleNotification() // << Здесь — если включено
                    } else {
                        NotificationManager.shared.removeScheduledNotifications()
                    }

                @unknown default:
                    self.isNotificationEnabled = false
                    NotificationManager.shared.removeScheduledNotifications()
                }
            }
        }
    }

}
