//
//  ContentView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        Group {
            if vm.username.isEmpty {
                OnboardingView()
            } else {
                LeetView()
            }
        }
        .frame(width: 400, height: 430)
    }
}
