//
//  ProblemsSolvedView.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/28/22.
//

import SwiftUI

struct ProblemsSolvedView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Solved Problems")
                    .foregroundColor(.secondary)
                Spacer()
                Button {
                    if let url = URL(string: vm.userProfileLink) {
                        openURL(url)
                    }
                } label: {
                    Label("View Profile", systemImage: "globe")
                }
                .disabled(vm.showLoading)
            }
            Divider()
            HStack {
                ProblemsSolvedCircle()
                ProblemsSolvedList()
            }
            .padding([.top], 4)
        }
        .padding()
        .thinBackground(cornerRadius: 10, opacity: 0.3)
    }
}

struct ProblemsSolvedCircle: View {
    
    @EnvironmentObject var vm: ViewModel
    
    let circleRadius: Double = 125
    let circleLineWidth: Double = 10
    
    var body: some View {
        ZStack {
            Circle()
                .strokeBorder(lineWidth: circleLineWidth)
                .foregroundColor(.grayCircleColor)
                .frame(width: circleRadius, height: circleRadius)
            
            Arc(
                startAngle: vm.showLoading ? .degrees(0) : .degrees(vm.mediumAngleEnd),
                endAngle: vm.showLoading ? .degrees(0) : .degrees(vm.hardAngleEnd),
                clockwise: true
            )
                .strokeBorder(.hardColor, style: StrokeStyle(lineWidth: circleLineWidth, lineCap: .butt))
                .frame(width: circleRadius, height: circleRadius)
            Arc(
                startAngle: vm.showLoading ? .degrees(0) : .degrees(vm.easyAngleEnd),
                endAngle: vm.showLoading ? .degrees(0) : .degrees(vm.mediumAngleEnd),
                clockwise: true
            )
                .strokeBorder(.mediumColor, style: StrokeStyle(lineWidth: circleLineWidth, lineCap: .butt))
                .frame(width: circleRadius, height: circleRadius)
            Arc(
                startAngle: .degrees(0),
                endAngle: vm.showLoading ? .degrees(0) : .degrees(vm.easyAngleEnd),
                clockwise: true
            )
            .strokeBorder(.easyColor, style: StrokeStyle(lineWidth: circleLineWidth, lineCap: .butt))
                .frame(width: circleRadius, height: circleRadius)
            
            
            if vm.showLoading {
                ProgressView()
            } else {
                VStack(spacing: 5) {
                    VStack {
                        Text("All")
                            .foregroundColor(.secondary)
                            .font(.title3)
                        Text("\(vm.allSolved)")
                            .font(.largeTitle)
                            .bold()
                            .minimumScaleFactor(0.01)
                            .lineLimit(1)
                    }
                    Text("\(vm.allTotal)")
                        .foregroundColor(.secondary)
                        .overlay(
                            Rectangle()
                                .frame(height: 1.25)
                                .foregroundColor(.gray)
                                .offset(y: -10)
                        )
                }
            }
        }
    }
}

struct ProblemsSolvedList: View {
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            ProblemsSolvedListItem(label: "Easy", color: .easyColor, solvedProblems: vm.easySolved, totalProblems: vm.easyTotal)
            ProblemsSolvedListItem(label: "Medium", color: .mediumColor, solvedProblems: vm.mediumSolved, totalProblems: vm.mediumTotal)
            ProblemsSolvedListItem(label: "Hard", color: .hardColor, solvedProblems: vm.hardSolved, totalProblems: vm.hardTotal)
        }
        .font(.title2)
        .padding([.leading], 20)
    }
}

struct ProblemsSolvedListItem: View {
    
    @EnvironmentObject var vm: ViewModel
    
    let label: String
    let color: Color
    let solvedProblems: Int
    let totalProblems: Int
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(color)
                .bold()
            
            Spacer()
            
            if vm.showLoading {
                Text("           ")
                    .redacted(reason: .placeholder)
            } else {
                
                HStack(spacing: 5) {
                    Text("\(solvedProblems)")
                        .bold()
                    Text("/")
                        .foregroundColor(.secondary)
                    Text("\(totalProblems)")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount = 0.0

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}
