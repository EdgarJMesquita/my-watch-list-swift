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
    
    override func getTMDBType() -> TMDBType {
        .tv
    }
    
    override func getTMDBCategory() -> TMDBCategory {
        .onTheAir
    }
}
