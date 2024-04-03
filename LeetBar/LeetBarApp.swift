//
//  LeetBarApp.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

@main
struct LeetBarApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var vm = ViewModel()
    @StateObject private var usernameInputWindowController = UsernameInputWindowController()

    var body: some Scene {
        MenuBarExtra("LeetBar", image: "LeetBarIcon") {
            ContentView()
                .environmentObject(vm)
                .environmentObject(usernameInputWindowController)
        }
        .menuBarExtraStyle(.window)
    }
}
