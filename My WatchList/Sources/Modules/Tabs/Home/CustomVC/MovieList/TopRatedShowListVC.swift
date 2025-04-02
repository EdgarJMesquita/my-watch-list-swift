//
//  TopRatedShowListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import Foundation
import UIKit

class TopRatedShowListVC: MovieListVC {
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
