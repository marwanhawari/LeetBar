//
//  ViewModel.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation
import SwiftUI

enum RefreshEvent: String {
    case changeUsername
    case openMenu
    case backgroundRefresh
}

@MainActor
final class ViewModel: ObservableObject {
    
    @Published var userProblemsSolved: UserProblemsSolved? = nil
    @Published var questionOfToday: QuestionOfToday? = nil
    
    @Published var easySolved: Int = 0
    @Published var easyTotal: Int = 0
    var easyAngleEnd: Double {
        return 360.0 * Double(easySolved) / Double(allTotal)
    }
    
    @Published var mediumSolved: Int = 0
    @Published var mediumTotal: Int = 0
    var mediumAngleEnd: Double {
        return (360.0 * Double(mediumSolved) / Double(allTotal)) + easyAngleEnd
    }
    
    @Published var hardSolved: Int = 0
    @Published var hardTotal: Int = 0
    var hardAngleEnd: Double {
        return (360.0 * Double(hardSolved) / Double(allTotal)) + mediumAngleEnd
    }
    
    @Published var allSolved: Int = 0
    @Published var allTotal: Int = 0
    
    @Published var username: String = ""
    @Published var isValidUsername: Bool = true
    
    @Published var showLoading: Bool = true
    
    var openedWindow: Bool = false
    var hasOpenedAfterFreshInstall: Bool = false

    private var lastRefreshed: Date = Date.distantPast
    private var backgroundTimer: Timer? = nil
    
    let baseURL = "https://leetcode.com"
    var apiURL: URL {
        URL(string: "\(baseURL)/graphql")!
    }
    
    let backgroundRefreshInterval: Double = 30
    
    var service: HTTPLeetService

    init(service: HTTPLeetService = LeetService()) {
        self.service = service
    }
    
    func fetchUserData(refreshEvent: RefreshEvent) async throws {
        if refreshEvent == .changeUsername {
            showLoading = true
        }

        let timeElapsedSinceLastRefresh = lastRefreshed.timeIntervalSinceNow
        if refreshEvent != .changeUsername && timeElapsedSinceLastRefresh > -10 {
            return
        }

        var userProblemsSolvedResponseResult: UserProblemsSolved? = nil
        var questionOfTodayResponseResult: QuestionOfToday? = nil
        
        do {
            async let userProblemsSolvedResponse: UserProblemsSolved? = try await service.httpPost(url: apiURL, payload: userProblemsSolvedPayload)
            async let questionOfTodayResponse: QuestionOfToday? = try await service.httpPost(url: apiURL, payload: questionOfTodayPayload)
            userProblemsSolvedResponseResult = try await userProblemsSolvedResponse
            questionOfTodayResponseResult = try await questionOfTodayResponse
        } catch {
            if refreshEvent == .changeUsername {
                username = ""
                isValidUsername = false
            }
            return
        }
        
        if userProblemsSolvedResponseResult?.data?.matchedUser != nil {
            userProblemsSolved = userProblemsSolvedResponseResult
            isValidUsername = true
        } else {
            userProblemsSolved = nil
            username = ""
            isValidUsername = false
        }

        transformProblemsSolvedData()

        if questionOfTodayResponseResult != nil {
            questionOfToday = questionOfTodayResponseResult
        }

        if refreshEvent == .changeUsername {
            await cancelBackgroundTimer()

            if isValidUsername {
                await startBackgroundTimer()
            }
        }
        
        NotificationManager.instance.cancelNotifications()
        if isValidUsername {
            NotificationManager.instance.scheduleDailyProblemNotification(subtitle: dailyProblemString)
        }

        showLoading = false
        lastRefreshed = Date.now
    }
    
    func startBackgroundTimer() async {
        guard backgroundTimer == nil else { return }
        backgroundTimer = Timer.scheduledTimer(withTimeInterval: backgroundRefreshInterval, repeats: true) { _ in
            Task {
                try await self.fetchUserData(refreshEvent: .backgroundRefresh)
            }
        }
    }
    
    func cancelBackgroundTimer() async {
        backgroundTimer?.invalidate()
        backgroundTimer = nil
    }
    
}
