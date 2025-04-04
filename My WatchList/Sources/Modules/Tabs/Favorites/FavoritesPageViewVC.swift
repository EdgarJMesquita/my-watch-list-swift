//
//  FavoritesPageViewVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation
import UIKit

class FavoritesPageViewVC: MWLPageViewVC {
    
    override func getPages() -> [UIViewController] {
        let favoritesMoviesVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
           contentView: MWLUsersMediaListView(),
           viewModel: MWLUsersMediaViewModel(service: FavoriteService(), type: .movies),
           title: "Favorites",
           flowDelegate: flowDelegate
       ))
       
       let favoritesTvVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
           contentView: MWLUsersMediaListView(),
           viewModel: MWLUsersMediaViewModel(service: FavoriteService(), type: .tv),
           title: "Favorites",
           flowDelegate: flowDelegate
       ))
        
        return [favoritesMoviesVC, favoritesTvVC]
    }
    
    override func getPagesNames() -> [String] {
        ["Movies", "Tv"]
    }
}
