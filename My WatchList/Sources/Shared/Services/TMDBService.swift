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

   
    func getData(type: TMDBType, category: TMDBCategory) async throws -> [Show] {
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }

        guard let url = URL(string: "\(baseURL)/\(type.rawValue)/\(category.rawValue)") else {
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

            return try JSONDecoder().decode(Result.self, from: data).results

        } catch {
            print(error)
            throw MWLError.invalidResponse
        }

    }
    
    func getDetails(for movieId: Int, category: TMDBCategory) async throws -> Credits {
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }

        guard let url = URL(string: "\(baseURL)/\(category.rawValue)/\(movieId)/credits") else {
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

            return try JSONDecoder().decode(Credits.self, from: data)

        } catch {
            print(error)
            throw MWLError.invalidResponse
        }

    }
    
    func downloadImage(path: String) async -> UIImage? {
        let urlString = "https://image.tmdb.org/t/p/w500/\(path)"
        
        guard let url = URL(string: urlString) else { return nil }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return nil
            }
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            print(error)
            return nil
        }
    }
    
    static func downloadImage(path: String) async -> UIImage? {
        let urlString = "https://image.tmdb.org/t/p/w500/\(path)"
        
        guard let url = URL(string: urlString) else { return nil }
       
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return nil
            }
            guard let image = UIImage(data: data) else { return nil }
            return image
        } catch {
            print(error)
            return nil
        }
    }
}
