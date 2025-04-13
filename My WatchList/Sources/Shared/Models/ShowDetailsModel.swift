//
//  ShowDetails.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/03/25.
//


import Foundation

// MARK: - Details
struct ShowDetails: Codable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int?
    let genres: [Genre]
    let homepage: String?
    let id: Int
    
    let originCountry: [String]
    let originalLanguage, overview: String
    let originalTitle: String?
    let originalName: String?
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String?
    let revenue, runtime: Int?
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title, name: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    
    let images: Images?
    
    let credits: Credits?
    let videos: VideosResult?
    
    let recommendations: Recommendations?

    let reviews: Reviews?
    
    func getType() -> TMDBType {
        title != nil ? .movie : .tv
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
      
        case images
        
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"

        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video, name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
        case videos, recommendations
        case reviews
    }
    
    func getTitle() -> String {
        return title ?? name ?? "Unknown"
    }
    
 
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}


struct Recommendations: Codable {
    let page: Int
    let results: [Media]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}


struct Reviews: Codable {
    let page: Int
    let results: [Review]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Review: Codable {
    let author: String
    let content: String
    let createdAt: String
    let updatedAt: String
    let id: String
    let url: String
    let authorDetails: AuthorDetails
   
    enum CodingKeys: String, CodingKey {
        case author, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id
        case url
        case authorDetails = "author_details"
    }
}


struct AuthorDetails: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, username, rating
        case avatarPath = "avatar_path"
    }
}
