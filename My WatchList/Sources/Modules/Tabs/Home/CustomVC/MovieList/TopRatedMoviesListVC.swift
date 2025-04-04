//
//  TrendingMoviesListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/03/25.
//

import UIKit

class TopRatedMoviesListVC: MovieListVC {
    override func getTitle() -> String {
        "Top Rated"
    }
    
    override func getTraktType() -> TMDBType {
        .movie
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .topRated
    }
}
