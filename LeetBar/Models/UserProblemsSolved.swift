//
//  UserProblemsSolved.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation

struct UserProblemsSolved: Codable {
    var data: UserProblemsSolvedData?
}

struct UserProblemsSolvedData: Codable {
    var allQuestionsCount: [QuestionCount]?
    var matchedUser: UserProblemsSolvedMatchedUser?
}

struct QuestionCount: Codable {
    var difficulty: String?
    var count: Int?
}

struct UserProblemsSolvedMatchedUser: Codable {
    var submitStatsGlobal: UserProblemsSolvedStats?
}

struct UserProblemsSolvedStats: Codable {
    var acSubmissionNum: [QuestionCount]?
}

