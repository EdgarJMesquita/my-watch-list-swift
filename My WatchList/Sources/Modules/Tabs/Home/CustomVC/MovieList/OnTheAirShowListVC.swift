//
//  OnTheAirShowListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import Foundation

class OnTheAirShowListVC: MovieListVC {
    override func getTitle() -> String {
        "On the air"
    }
    
    override func getTraktType() -> TMDBType {
        .tv
    }
    
    override func getTraktCategory() -> TMDBCategory {
        .onTheAir
    }
}
