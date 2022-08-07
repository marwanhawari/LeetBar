//
//  Services.swift
//  LeetBar
//
//  Created by Marwan Hawari on 8/5/22.
//

import Foundation

protocol HTTPLeetService {
    func httpPost<T: Codable>(url: URL, payload: GraphQLPayload) async throws -> T
}

class LeetService: HTTPLeetService {
    func httpPost<T: Codable>(url: URL, payload: GraphQLPayload) async throws -> T {
        
        let payloadJSON = try JSONEncoder().encode(payload)
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = payloadJSON
        
        let (responseData, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(T.self, from: responseData)
        
        return result
    }
}
