//
//  PopularShowsListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/03/25.
//

import UIKit

class PopularShowsListVC: MovieListVC {
    override func getTitle() -> String {
        "Popular TV shows"
    }
    
    override func getTMDBType() -> TMDBType {
        .tv
    }
    
    override func getTMDBCategory() -> TMDBCategory {
        .popular
    }
}
