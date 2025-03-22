//
//  TrendingShowsListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/03/25.
//

import UIKit

class TrendingShowsListVC: MovieListVC {
    override func getTitle() -> String {
        "Top Rated TV shows"
    }
    
    override func getTraktType() -> TMDBType {
        .tv
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .topRated
    }
}
