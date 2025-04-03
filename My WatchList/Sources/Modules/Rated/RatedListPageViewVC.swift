//
//  RatedPageVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/04/25.
//

import Foundation
import UIKit

class RatedListPageViewVC: MWLPageViewVC {
    
    override func getPages() -> [UIViewController] {
        let ratedMoviesVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
           contentView: MWLUsersMediaListView(),
           viewModel: MWLUsersMediaViewModel(service: RatedService(), type: .movies),
           title: "Rated",
           flowDelegate: flowDelegate
        ))
        
        let ratedTvVC = UINavigationController(rootViewController: MWLUsersMediaListVC(
            contentView: MWLUsersMediaListView(),
            viewModel: MWLUsersMediaViewModel(service: RatedService(), type: .tv),
            title: "Rated",
            flowDelegate: flowDelegate
        ))

        return [ratedMoviesVC, ratedTvVC]
    }
    
    override func getPagesNames() -> [String] {
        ["Movies", "Tv"]
    }
    
}
