//
//  UserProblemsSolvedExtension.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation

extension ViewModel {
    var userProblemsSolvedPayload: GraphQLPayload{
        GraphQLPayload(
            query: userProblemsSolvedQuery,
            operationName: "userProblemsSolved",
            variables: GraphQLPayloadVariables(username: username)
        )
    }
    
    func transformProblemsSolvedData() {
        if let questionDifficultiesSolved: [QuestionCount] = userProblemsSolved?.data?.matchedUser?.submitStatsGlobal?.acSubmissionNum {
            for questionSolved in questionDifficultiesSolved {
                switch questionSolved.difficulty {
                case "All":
                    allSolved = questionSolved.count ?? 0
                case "Easy":
                    easySolved = questionSolved.count ?? 0
                case "Medium":
                    mediumSolved = questionSolved.count ?? 0
                case "Hard":
                    hardSolved = questionSolved.count ?? 0
                default:
                    continue
                }
            }
        } else {
            allSolved = 0
            easySolved = 0
            mediumSolved = 0
            hardSolved = 0
        }
        
        if let questionDifficultiesTotal: [QuestionCount] = userProblemsSolved?.data?.allQuestionsCount {
            for questionTotal in questionDifficultiesTotal {
                switch questionTotal.difficulty {
                case "All":
                    allTotal = questionTotal.count ?? 0
                case "Easy":
                    easyTotal = questionTotal.count ?? 0
                case "Medium":
                    mediumTotal = questionTotal.count ?? 0
                case "Hard":
                    hardTotal = questionTotal.count ?? 0
                default:
                    continue
                }
            }
        } else {
            allTotal = 0
            easyTotal = 0
            mediumTotal = 0
            hardTotal = 0
        }
    }
    
    var userProfileLink: String {
        "\(baseURL)/\(username)/"
    }
}
