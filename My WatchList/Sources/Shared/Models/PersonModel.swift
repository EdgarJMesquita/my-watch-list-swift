//
//  PersonDetailsModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import Foundation

// MARK: - PersonDetails
struct Person: Codable {
    let adult: Bool
    let alsoKnownAs: [String]
    let biography, birthday: String?
    let deathday: String?
    let gender: Int?
    let homepage: String?
    let id: Int
    let name: String
    let placeOfBirth: String?
    let popularity: Double
    let profilePath: String?
    let images: Images?
    let combinedCredits: CombinedCredits?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id

        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case images
        case combinedCredits = "combined_credits"
    }
}

// MARK: - CombinedCredits
struct CombinedCredits: Codable {
    let cast: [Show]?
    let crew: [Crew]?
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

struct PersonCast: Codable {
    let adult: Bool
    let backdropPath: String?
    
    let id: Int
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let character, creditID: String
    let order: Int?
    let mediaType: MediaType
    let originCountry: [String]?
    let originalName, firstAirDate, name: String?
    let episodeCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order
        case mediaType = "media_type"
        case originCountry = "origin_country"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case name
        case episodeCount = "episode_count"
    }
}

// MARK: - Crew
struct Crew: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int?
    let creditID, job: String?
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case creditID = "credit_id"
        case job
        case mediaType = "media_type"
    }
}

// MARK: - Images
struct Images: Codable {
    let profiles: [Profile]?
}

// MARK: - Profile
struct Profile: Codable {
    let aspectRatio: Double
    let height: Int
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
