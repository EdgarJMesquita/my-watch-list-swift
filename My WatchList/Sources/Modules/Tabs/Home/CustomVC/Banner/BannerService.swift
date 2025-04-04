//
//  BannerService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation

class BannerService: ShowDetailsService {
    
    func getTrendingMovies() async throws -> [Media] {
        let path = "/trending/movie/day"
        return try await request(with: path, model: ShowResponse.self).results
    }
}
