//
//  AppMenu.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

class AppMenu: NSObject {
    let menu = NSMenu()
    
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

    
    @objc func quit(sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
