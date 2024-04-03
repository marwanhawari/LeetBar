//
//  Settings.swift
//  LeetBar
//
//  Created by Marwan Hawari on 4/2/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            LaunchAtLogin.Toggle()
            Text("Automatically launches LeetBar when you start your Mac")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
        .padding()
        .frame(width: 325, height: 100)
    }
}
