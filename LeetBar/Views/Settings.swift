//
//  Settings.swift
//  LeetBar
//
//  Created by Marwan Hawari on 4/2/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.title)
                .padding()
            
            Button("Close") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .frame(width: 400, height: 300)
    }
}
