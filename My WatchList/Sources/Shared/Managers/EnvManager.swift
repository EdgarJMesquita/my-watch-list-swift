//
//  EnvManager.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import Foundation

final class EnvManager {
    enum Key: String {
        case traktClientId = "TRAKT_CLIENT_ID"
        case omdbAPIKey = "OMDB_API_KEY"
        case tmdbAPIKey = "TMDB_API_KEY"
    }

    static func get(key: Key) -> String? {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
        else { return nil }
        return value
    }
}
