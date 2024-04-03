//
//  SettingsView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

struct UsernameInputView: View {
    @State private var username = ""
    @ObservedObject var vm: ViewModel
    @EnvironmentObject private var usernameInputWindowController: UsernameInputWindowController
    
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
        usernameInputWindowController.close()
        try? await vm.fetchUserData(refreshEvent: .changeUsername)
    }
    
    func cancelSettings() {
        usernameInputWindowController.close()
    }
}


