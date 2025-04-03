//
//  WatchListPageViewVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation

import UIKit

class WatchListPageViewVC: MWLPageViewVC {
    override func getPages() -> [UIViewController] {
        let favoritesMoviesVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
           contentView: MWLUsersMediaListView(),
           viewModel: MWLUsersMediaViewModel(service: WatchListService(), type: .movies),
           title: "WatchList",
           flowDelegate: flowDelegate
       ))
       
       let favoritesTvVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
           contentView: MWLUsersMediaListView(),
           viewModel: MWLUsersMediaViewModel(service: WatchListService(), type: .tv),
           title: "WatchList",
           flowDelegate: flowDelegate
       ))
        
        return [favoritesMoviesVC, favoritesTvVC]
    }
    
    override func getPagesNames() -> [String] {
        ["Movies", "Tv"]
    }
}
