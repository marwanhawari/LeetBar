//
//  AppDelegate.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        UNUserNotificationCenter.current().delegate = self
        
        // Check notification authorization status before requesting
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                // Only request authorization if it has not been requested before
                NotificationManager.instance.requestAuthorization()
            }
        }
    }

    func applicationWillTerminate(_ notification: Notification) {
        // Cancel all notifications when quitting the app
        NotificationManager.instance.cancelNotifications()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let problemLinkString = userInfo["problemLink"] as? String, let problemLink = URL(string: problemLinkString) {
            NSWorkspace.shared.open(problemLink)
        }
        completionHandler()
    }
}
