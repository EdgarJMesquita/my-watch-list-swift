//
//  RatedService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/04/25.
//

import Foundation

class RatedService: RequestService, MWLUsersMediaServiceProtocol {
  
    func getItems(accountId: Int, type: UserMediaType) async throws -> [Media] {
        let path = "/account/\(accountId)/rated/\(type.rawValue)"
        return try await request(with: path, model: ShowResponse.self, cache: false).results
    }
    
}
