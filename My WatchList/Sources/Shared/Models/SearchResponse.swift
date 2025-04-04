//
//  SearchResults.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 25/03/25.
//

import Foundation


import Foundation

// MARK: - SearchResults
struct SearchResponse: Codable {
    let page: Int
    let results: [Media]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
