//
//  File.swift
//  My WatchList
//
//  Created by Edgar on 07/04/25.
//

import Foundation

class UserRatedTVListVC: BaseUserRatedListVC {
    override func getTitle() -> String {
        "My Rated TV Show"
    }
    
    override func getUserListType() -> UserMediaType {
        .tv
    }
}
