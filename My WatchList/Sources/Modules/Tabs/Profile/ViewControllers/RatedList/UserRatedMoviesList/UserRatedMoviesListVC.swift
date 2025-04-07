//
//  RatedMoviesListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 07/04/25.
//

import Foundation

class UserRatedMoviesListVC: BaseUserRatedListVC {
    override func getTitle() -> String {
        "My Rated Movies"
    }
    
    override func getUserListType() -> UserMediaType {
        .movies
    }
}
