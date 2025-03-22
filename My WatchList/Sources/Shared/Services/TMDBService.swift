//
//  TMDBService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 14/03/25.
//

import Foundation


import Foundation
import UIKit

enum TMDBCategory:String {
    case popular = "popular"
    case topRated = "top_rated"
}

enum TMDBType:String {
    case movie = "movie"
    case tv = "tv"
}

class TMDBService {

    let cache = NSCache<NSString, UIImage>()
    private let baseURL = "https://api.themoviedb.org/3"

   
    private func request<T>(with urlString: String, model: T.Type) async throws -> T where T : Decodable {
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }

        guard let url = URL(string: urlString) else {
            throw MWLError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw MWLError.invalidResponse
            }

            return try JSONDecoder().decode(model, from: data)

        } catch {
            print(error)
            throw MWLError.invalidResponse
        }

    }
    
    func getShows(type: TMDBType, category: TMDBCategory) async throws -> [Show] {
        let urlString = "\(baseURL)/\(type.rawValue)/\(category.rawValue)"
        return try await request(with: urlString, model: Result.self).results
    }
    
    func getShowDetails(for movieId: Int, type: TMDBType) async throws -> ShowDetails {
        let urlString = "\(baseURL)/\(type.rawValue)/\(movieId)?append_to_response=credits,videos,recommendations,images&language=en-US"
        return try await request(with: urlString, model: ShowDetails.self)
    }
    
    func getPersonDetails(for personId: Int) async throws -> Person {
        let urlString = "\(baseURL)/person/\(personId)?append_to_response=images,combined_credits"
        return try await request(with: urlString, model: Person.self)
    }
}
