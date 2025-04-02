//
//  FavoriteModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 27/03/25.
//

import Foundation


struct Favorite: Codable, Hashable {
    let id: Int
    let title: String

    let mediaType: MediaType

    let voteCount: Int?
    let imagePath: String?
    let description: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
