//
//  MediaStates.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 30/03/25.
//

import Foundation

// MARK: - MediaStates
struct MediaStates: Codable {
    let id: Int
    let favorite, watchlist, rated: Bool
}
