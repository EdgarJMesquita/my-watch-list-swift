//
//  FavoriteService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 29/03/25.
//

import Foundation
import UIKit



enum FavoriteType: String {
    case movies = "movies"
    case tv = "tv"
}

class FavoriteService: RequestService, MWLUsersMediaServiceProtocol {
    
    func getItems(accountId: Int, type: UserMediaType) async throws -> [Media] {
        let path = "/account/\(accountId)/favorite/\(type.rawValue)"
        return try await request(with: path, model: ShowResponse.self, cache: false).results
    }
    
}
