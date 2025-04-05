//
//  TMDBService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 14/03/25.
//

import Foundation
import UIKit


enum TMDBCategory:String {
    case popular = "popular"
    case topRated = "top_rated"
    /** TV Only */
    case airingTotay = "airing_today"
    /** TV Only */
    case onTheAir = "on_the_air"
    /** Movie Only */
    case upcoming = "upcoming"
    /** Movie Only */
    case nowPlaying = "now_playing"
}


enum TMDBType:String {
    case movie = "movie"
    case tv = "tv"
}


class ShowService: RequestService {
   
    
    func getShows(type: TMDBType, category: TMDBCategory) async throws -> [Media] {
        let path = "/\(type.rawValue)/\(category.rawValue)"
        return try await request(with: path, model: ShowResponse.self).results
    }
    
    
    func getShowDetails(for movieId: Int, type: TMDBType) async throws -> ShowDetails {
        let path = "/\(type.rawValue)/\(movieId)"
        let queryItems = [URLQueryItem(name: "append_to_response", value: "credits,videos,recommendations,images")]
        return try await request(with: path, model: ShowDetails.self, queryItems: queryItems)
    }
    
    
    func getShows(type: TMDBType, category: TMDBCategory, page: Int) async throws -> [Media] {
        let path = "/\(type.rawValue)/\(category.rawValue)"
        let queryParams = [URLQueryItem(name: "page", value: "\(page)")]
        return try await request(with: path, model: ShowResponse.self, queryItems: queryParams).results
    }
    
//    func getPersonDetails(for personId: Int) async throws -> Person {
//        let path = "/person/\(personId)"
//        let queryItems = [URLQueryItem(name: "append_to_response", value: "images,combined_credits")]
//        return try await request(with: path, model: Person.self, queryItems: queryItems)
//    }
//    
    
    func search(query: String) async throws -> [Media] {
        let path = "/search/multi"
        let queryItems = [URLQueryItem(name: "query", value: query)]
        return try await request(with: path, model: SearchResponse.self, queryItems: queryItems).results
    }
    
}
