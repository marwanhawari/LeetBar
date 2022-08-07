//
//  ContentView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        
        Group {
            if vm.username != "" {
                LeetView()
            } else {
                OnboardingView()
            }
        }
        .environmentObject(vm)
        .task {
            if !vm.hasOpenedAfterFreshInstall { // if opening it for the first time since installing the app...
                
                // Request notifications
                NotificationManager.instance.requestAuthorization()
                
                vm.hasOpenedAfterFreshInstall = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 400, height: 430)
    }
}


