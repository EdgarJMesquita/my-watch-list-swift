//
//  MediaModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation


// MARK: - Media
struct Media: Codable, Hashable {
    let id: Int
    let name: String?
    let posterPath: String?
    let mediaType: MediaType?
    let adult: Bool
    let popularity: Double
    let voteCount: Int?
    let title: String?
    let profilePath: String?
  
    func getTitle() -> String {
        name ?? title ?? "Unknown"
    }
    
    func getImagePath() -> String? {
        posterPath ?? profilePath
    }
    
    func getType() -> TMDBType {
        title != nil ? .movie : .tv
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult
        case popularity
        case voteCount = "vote_count"
        case title
        case profilePath = "profile_path"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

