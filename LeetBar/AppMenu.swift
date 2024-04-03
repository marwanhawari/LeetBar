//
//  AppMenu.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

class AppMenu: NSObject {
    let menu = NSMenu()
    var settingsWindow: NSWindow?
    
    func createMenu() -> NSMenu {
        let contentView = ContentView()
        let rootView = NSHostingController(rootView: contentView)
        rootView.view.frame.size = CGSize(width: 400, height: 430)
        
        let customMenuItem = NSMenuItem()
        customMenuItem.view = rootView.view
        menu.addItem(customMenuItem)
        menu.addItem(NSMenuItem.separator())
        
        let aboutMenuItem = NSMenuItem(title: "About LeetBar",
                                       action: #selector(about),
                                       keyEquivalent: "")
        aboutMenuItem.target = self
        menu.addItem(aboutMenuItem)
        
        let settingsMenuItem = NSMenuItem(title: "Settings",
                                          action: #selector(settings),
                                          keyEquivalent: ",")
        settingsMenuItem.target = self
        menu.addItem(settingsMenuItem)

        let quitMenuItem = NSMenuItem(title: "Quit",
                                       action: #selector(quit),
                                       keyEquivalent: "q")
        quitMenuItem.target = self
        menu.addItem(quitMenuItem)
        
        return menu
    }
    
    @objc func about(sender: NSMenuItem) {
        NSApp.orderFrontStandardAboutPanel()
        NSApp.arrangeInFront(nil)
    }

    @objc func settings(sender: NSMenuItem) {
        if settingsWindow == nil {
            let settingsView = SettingsView()
            let window = NSWindow(contentViewController: NSHostingController(rootView: settingsView))
            window.setContentSize(NSSize(width: 400, height: 300))
            window.styleMask.remove(.miniaturizable)
            window.styleMask.remove(.resizable)
            window.title = "Settings"
            window.center()
            window.setFrameAutosaveName("Settings")
            window.makeKeyAndOrderFront(nil)
            window.orderFrontRegardless()
            
            settingsWindow = window
            
            window.delegate = self
        } else {
            settingsWindow?.makeKeyAndOrderFront(nil)
            settingsWindow?.orderFrontRegardless()
        }
    }
    
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}

extension AppMenu: NSWindowDelegate {
    func windowWillClose(_ notification: Notification) {
        settingsWindow = nil
    }
}
