//
//  ShowDetailsService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation
import UIKit


class ShowDetailsService: RequestService {
   

    func getShowDetails(for movieId: Int, type: TMDBType) async throws -> ShowDetails {
        let path = "/\(type.rawValue)/\(movieId)"
        let queryItems = [URLQueryItem(name: "append_to_response", value: "credits,videos,recommendations,images")]
        return try await request(with: path, model: ShowDetails.self, queryItems: queryItems)
    }
    
    
    func getMediaStatus(mediaId: Int, type: TMDBType) async throws -> MediaStates {
        let path = "/\(type.rawValue)/\(mediaId)/account_states"
        return try await request(with: path, model: MediaStates.self, cache: false)
    }
    
    
    func updateMediaFavorite(accountId: Int, mediaId: Int, mediaType: TMDBType, favorite: Bool) async throws {
        let path = "/account/\(accountId)/favorite"
        let parameters:[String : Any?] = [
            "media_type": mediaType.rawValue,
            "media_id": mediaId,
            "favorite": favorite
        ]
        return try await create(with: path, body: parameters)
    }

    func updateMediaWatchList(accountId: Int, mediaId: Int, mediaType: TMDBType, watchList: Bool) async throws {
        let path = "/account/\(accountId)/watchlist"
        let parameters:[String : Any?] = [
            "media_type": mediaType.rawValue,
            "media_id": mediaId,
            "watchlist": watchList
        ]
        return try await create(with: path, body: parameters)
    }
    
    func updateRate(mediaId: Int, mediaType: TMDBType, rate: Float) async throws {
        let path = "/\(mediaType.rawValue)/\(mediaId)/rating"
        let parameters:[String : Float] = [
            "value": rate
        ]
        return try await create(with: path, body: parameters)
    }
    
    func deleteRate(mediaId: Int, mediaType: TMDBType) async throws {
        let path = "/\(mediaType.rawValue)/\(mediaId)/rating"
        return try await delete(with: path)
    }
}
