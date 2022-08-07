//
//  Notifications.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/30/22.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Successfully authorized notifications")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func scheduleDailyProblemNotification(subtitle: String) {
        let content = UNMutableNotificationContent()
        content.title = "New Daily Problem"
        content.subtitle = subtitle
        content.sound = UNNotificationSound.default
        
        let dailyProblemSchedule = DateComponents(
            timeZone: TimeZone(identifier: "UTC"),
            hour: 0,
            minute: 0,
            second: 40 // Set it at 40 seconds because want to guarantee that there was a background refresh before the notification is sent
        )
        let trigger = UNCalendarNotificationTrigger(dateMatching: dailyProblemSchedule, repeats: true)
        
        let request = UNNotificationRequest(identifier: "newDailyProblem", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}
