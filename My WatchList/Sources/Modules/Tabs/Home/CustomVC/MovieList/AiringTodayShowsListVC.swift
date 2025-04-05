//
//  TrendingShowsListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/03/25.
//

import UIKit

class AiringTodayShowsListVC: MovieListVC {
    override func getTitle() -> String {
        "Airing Today"
    }
    
    override func getTMDBType() -> TMDBType {
        .tv
    }
    
    override func getTMDBCategory() -> TMDBCategory {
        .airingTotay
    }
}
