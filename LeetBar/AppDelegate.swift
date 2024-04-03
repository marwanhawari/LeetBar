//
//  AppDelegate.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI
import UserNotifications

class AppDelegate: NSObject, NSApplicationDelegate, UNUserNotificationCenterDelegate {
    static private(set) var instance: AppDelegate!
    lazy var statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let menu = AppMenu()
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        AppDelegate.instance = self
        statusBarItem.button?.image = NSImage(named: NSImage.Name("LeetBarIcon"))
        statusBarItem.button?.image?.isTemplate = true
        statusBarItem.button?.imagePosition = .imageLeading
        statusBarItem.menu = menu.createMenu()

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
