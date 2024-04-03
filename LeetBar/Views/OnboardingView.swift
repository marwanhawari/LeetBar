//
//  OnboardingView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/31/22.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        VStack {
            if !vm.isValidUsername {
                Text("User Data Not Found")
                    .padding(10)
                    .thinBackground(cornerRadius: 10, opacity: 0.3)
            }
            
            Button {
                if !vm.openedWindow {
                    vm.openedWindow = true
                    UsernameInputView(vm: vm).openNewWindow()
                }
            } label: {
                Label("Enter a Username", systemImage: "person.fill")
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
