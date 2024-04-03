//
//  LeetView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/31/22.
//

import SwiftUI

struct LeetView: View {
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject private var usernameInputWindowController: UsernameInputWindowController
    
    var body: some View {
        VStack {
            VStack {
                Text("\(vm.username)")
                    .font(.title2)
                    .bold()
                    .redacted(reason: vm.showLoading ? .placeholder : [])
                Button {
                    usernameInputWindowController.open()
                } label: {
                    Label("Change Username", systemImage: "person.fill")
                }
            }
            .padding([.bottom], 10)
                
            DailyProblemView()
            ProblemsSolvedView()
            
        }
        .padding([.horizontal], 14) // 14 is the pixel perfect padding so that the edges line up with the divider
        .task {
            
            try? await vm.fetchUserData(refreshEvent: .openMenu)
            
        }
    }
}

struct LeetView_Previews: PreviewProvider {
    static var previews: some View {
        LeetView()
    }
}
