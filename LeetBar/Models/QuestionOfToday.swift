//
//  QuestionOfToday.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation

struct QuestionOfToday: Codable {
    var data: QuestionOfTodayData?
}

struct QuestionOfTodayData: Codable {
    var activeDailyCodingChallengeQuestion: ActiveDailyCodingChallengeQuestion?
}

struct ActiveDailyCodingChallengeQuestion: Codable {
    var link: String?
    var question: Question?
}

struct Question: Codable {
    var difficulty: String?
    var frontendQuestionId: String?
    var title: String?
}
