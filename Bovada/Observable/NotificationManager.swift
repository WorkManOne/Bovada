//
//  NotificationManager.swift
//  Pinup
//
//  Created by Кирилл Архипов on 07.07.2025.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Play smarter. Learn from your rivals."
        content.body = "Log your last match while it’s fresh in your mind. Note your opponent’s style, strengths, and weaknesses. Gain the edge next time."
        content.sound = .default

        var triggerDate = DateComponents()
        triggerDate.hour = 10
        triggerDate.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyChecklist", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }

    func removeScheduledNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
}
