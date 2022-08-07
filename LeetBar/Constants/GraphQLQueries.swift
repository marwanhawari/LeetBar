//
//  Payloads.swift
//  leetcode
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation
import SwiftUI

let userProblemsSolvedQuery = "query userProblemsSolved($username: String!) {\n allQuestionsCount {\n difficulty\n count\n }\n matchedUser(username: $username) {\n submitStatsGlobal {\n acSubmissionNum {\n difficulty\n count\n }\n }\n }\n}\n"
let questionOfTodayQuery = "query questionOfToday {\n activeDailyCodingChallengeQuestion {\n link\n question {\n difficulty\n frontendQuestionId: questionFrontendId\n title \n }\n }\n}\n"

