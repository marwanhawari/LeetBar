//
//  MockLeetServices.swift
//  LeetBarTests
//
//  Created by Marwan Hawari on 8/5/22.
//

import Foundation
@testable import LeetBar

class MockLeetServiceNil: HTTPLeetService {
    func httpPost<T: Codable>(url: URL, payload: GraphQLPayload) async throws -> T {

        if payload.operationName == "userProblemsSolved" {
            let mockResult: UserProblemsSolved? = nil
            return mockResult as! T
        } else {
            let mockResult: QuestionOfToday? = nil
            return mockResult as! T
        }
    }
}


class MockLeetServiceWithData: HTTPLeetService {
    func httpPost<T: Codable>(url: URL, payload: GraphQLPayload) async throws -> T {

        if payload.operationName == "userProblemsSolved" {
            let mockResult = UserProblemsSolved(data: UserProblemsSolvedData(allQuestionsCount: [QuestionCount(difficulty: "All", count: 2362), QuestionCount(difficulty: "Easy", count: 586), QuestionCount(difficulty: "Medium", count: 1257), QuestionCount(difficulty: "Hard", count: 519)], matchedUser: UserProblemsSolvedMatchedUser(submitStatsGlobal: UserProblemsSolvedStats(acSubmissionNum: [QuestionCount(difficulty: "All", count: 312), QuestionCount(difficulty: "Easy", count: 103), QuestionCount(difficulty: "Medium", count: 195), QuestionCount(difficulty: "Hard", count: 14)]))))
            return mockResult as! T
            
        } else {
            let mockResult = QuestionOfToday(data: QuestionOfTodayData(activeDailyCodingChallengeQuestion: ActiveDailyCodingChallengeQuestion(link: "/problems/mock-link/", question: Question(difficulty: "Medium", frontendQuestionId: "100", title: "Mock Question Title"))))
            return mockResult as! T
        }
    }
}
