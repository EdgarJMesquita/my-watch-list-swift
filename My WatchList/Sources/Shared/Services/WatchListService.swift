//
//  WatchListService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 31/03/25.
//

import Foundation
import UIKit

fileprivate let baseURL = Constants.TMDBBaseURL.rawValue

enum WatchListType: String {
    case movies = "movies"
    case tv = "tv"
}

class WatchListService: RequestService, MWLUsersMediaServiceProtocol {
  
    func getItems(accountId: Int, type: UserMediaType) async throws -> [Media] {
        let path = "/account/\(accountId)/watchlist/\(type.rawValue)"
        return try await request(with: path, model: ShowResponse.self, cache: false).results
    }
    
}
