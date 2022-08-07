//
//  DailyProblemView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

struct DailyProblemView: View {
    @Environment(\.openURL) private var openURL
    @EnvironmentObject var vm: ViewModel

    let easyGreen = Color.green
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                
                Text("Daily Problem")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button {
                    if let url = URL(string: vm.dailyProblemLink) {
                        openURL(url)
                    }
                } label: {
                    Label("View Problem", systemImage: "globe")
                }
                .disabled(vm.showLoading)
            }
            
            Divider()
                
            VStack(alignment: .leading, spacing: 5) {
                Text(vm.dailyProblemString)
                    .font(.title2)
                    .minimumScaleFactor(0.01)
                    .lineLimit(2)
                Text(vm.dailyProblemDifficulty)
                    .font(.headline)
                    .foregroundColor(vm.showLoading ? .primary : vm.dailyProblemDifficultyColor)
                    
            }
            .redacted(reason: vm.showLoading ? .placeholder : [])
            .frame(height: 60)
        }
        .padding()
        .thinBackground(cornerRadius: 10, opacity: 0.3)
    }
}

