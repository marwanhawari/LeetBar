//
//  GraphQLPayload.swift
//  LeetBar
//
//  Created by Marwan Hawari on 7/26/22.
//

import Foundation

struct GraphQLPayload: Codable {
    var query: String
    var operationName: String
    var variables: GraphQLPayloadVariables?
}

struct GraphQLPayloadVariables: Codable {
    var username: String?
}
