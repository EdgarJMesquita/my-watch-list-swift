//
//  UpcomingMoviesListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import UIKit

class UpcomingMoviesListVC: MovieListVC {
    override func getTitle() -> String {
        "Upcoming"
    }
    
    override func getTraktType() -> TMDBType {
        .movie
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .upcoming
    }
}
