//
//  TabbarFlowDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 15/03/25.
//

import Foundation


protocol TabBarFlowDelegate: AnyObject, PresentShowDetailsProtocol, PresentPersonDetailsProtocol, ResetAppProtocol {
    func navigateToTabBarHome()
    func navigateToTabBarSearch()
    func navigateToTabBarProfile()
    func navigateToRatedListPageView()
}
