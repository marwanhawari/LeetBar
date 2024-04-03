//
//  UsernameInputView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

extension View {
    private func newWindowInternal(with title: String) -> NSWindow {
        let window = NSWindow(
            contentRect: NSRect(x: 20, y: 20, width: 680, height: 600),
            styleMask: [.titled, .fullSizeContentView],
            backing: .buffered,
            defer: false)
        window.center()
        window.isReleasedWhenClosed = false
        window.title = title
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
        return window
    }
    
    func openNewWindow(with title: String = "LeetBar Preferences") {
        self.newWindowInternal(with: title).contentView = NSHostingView(rootView: self)
    }
}

struct UsernameInputView: View {
    @State private var username = ""
    @ObservedObject var vm: ViewModel
    
    var cleanedUsername: String {
        username.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Username")
                TextField("", text: $username)
                    .onSubmit {
                        Task {
                            await submitSettings()
                        }
                    }
                    .textFieldStyle(.roundedBorder)
            }
            .padding()

            HStack {
                Button("Cancel") {
                    cancelSettings()
                }
                Button("Done") {
                    Task {
                        await submitSettings()
                    }
                }
                .buttonStyle(.borderedProminent)
            }
            
        }
        .padding()
        .frame(width: 350, height: 200)
    }
    
    func submitSettings() async {
        if cleanedUsername == "" {
            return
        }
        vm.username = cleanedUsername
        vm.openedWindow = false
        NSApplication.shared.keyWindow?.close()
        try? await vm.fetchUserData(refreshEvent: .changeUsername)
    }
    
    func cancelSettings() {
        vm.openedWindow = false
        NSApplication.shared.keyWindow?.close()
    }
}


