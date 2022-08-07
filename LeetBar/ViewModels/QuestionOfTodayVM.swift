//
//  QuestionOfTodayExtension.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation
import SwiftUI

extension ViewModel {
    var questionOfTodayPayload: GraphQLPayload {
        GraphQLPayload(
            query: questionOfTodayQuery,
            operationName: "questionOfToday",
            variables: GraphQLPayloadVariables(username: username)
        )
    }
    
    var dailyProblemLink: String {
        guard let unwrappedDailyProblemLink = questionOfToday?.data?.activeDailyCodingChallengeQuestion?.link else {
            return ""
        }
        return "\(baseURL)\(unwrappedDailyProblemLink)"
    }
    
    var dailyProblemNumber: String {
        guard let unwrappedDailyProblemNumber = questionOfToday?.data?.activeDailyCodingChallengeQuestion?.question?.frontendQuestionId else {
            return "     "
        }
        return "\(unwrappedDailyProblemNumber). "
    }
    
    var dailyProblemTitle: String {
        guard let unwrappedDailyProblemTitle = questionOfToday?.data?.activeDailyCodingChallengeQuestion?.question?.title else {
            return "                         "
        }
        return unwrappedDailyProblemTitle
    }
    
    var dailyProblemDifficulty: String {
        guard let unwrappedDailyProblemDifficulty = questionOfToday?.data?.activeDailyCodingChallengeQuestion?.question?.difficulty else {
            return "          "
        }
        return unwrappedDailyProblemDifficulty
    }
    
    var dailyProblemDifficultyColor: Color {
        switch dailyProblemDifficulty {
        case "Easy":
            return .easyColor
        case "Medium":
            return .mediumColor
        case "Hard":
            return .hardColor
        default:
            return .primary
        }
    }
    
    var dailyProblemString: String {
        return "\(dailyProblemNumber)\(dailyProblemTitle)"
    }
}
