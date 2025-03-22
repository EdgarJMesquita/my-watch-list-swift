//
//  ShowModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 14/03/25.
//

import Foundation


// MARK: - Show
struct Result: Codable {
    let page: Int
    let results: [Show]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Show: Codable {
    let adult: Bool
    let backdropPath: String?
    
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let originalName: String?
    let overview: String
    let name: String?
    let popularity: Double
    let releaseDate: String?
    let posterPath: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case name
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    func getTitle() -> String {
        return name ?? title ?? "Unknown"
    }
    
    func getType() -> TMDBType {
        return title != nil ? .movie : .tv
    }
    
    static func buildMock() -> Show {
        let show = Show(
            adult: false,
            backdropPath: "/gFFqWsjLjRfipKzlzaYPD097FNC.jpg",
            id: 1126166,
            originalLanguage: "en",
            originalTitle: "Flight Risk",
            originalName: nil,
            overview: "A U.S. Marshal escorts a government witness to trial after he's accused of getting involved with a mob boss, only to discover that the pilot who is transporting them is also a hitman sent to assassinate the informant. After they subdue him, they're forced to fly together after discovering that there are others attempting to eliminate them.",
            name: nil,
            popularity: 25.919,
            releaseDate: "2025-01-22",
            posterPath: "/q0bCG4NX32iIEsRFZqRtuvzNCyZ.jpg",
            title: "Flight Risk",
            video: false,
            voteAverage: 6.1,
            voteCount: 469
        )
        return show
    }
}


