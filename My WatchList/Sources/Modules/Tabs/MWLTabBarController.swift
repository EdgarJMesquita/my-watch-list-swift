//
//  File.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class MWLTabBarController: UITabBarController {
    
    
    weak var flowDelegate: TabBarFlowDelegate?
    let previousIndex: Int
    
    
    init(flowDelegate: TabBarFlowDelegate? = nil, previousIndex: Int) {
        self.flowDelegate = flowDelegate
        self.previousIndex = previousIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .mwlSurface
        tabBar.isTranslucent = false
        tabBar.tintColor = .mwlPrimary
        tabBar.unselectedItemTintColor = .white
        tabBar.barStyle = .default
        viewControllers = [
            createHomeNC(),
            createSearchNC(),
            createFavoritesNC(),
            createWatchListNC(),
            createProfileNC()
        ]
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    
    private func createHomeNC() -> UIViewController {
        let homeVC = HomeVC(contentView: HomeView(),flowDelegate: flowDelegate, previousIndex: previousIndex)
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .mwlHome, tag: 0)
        setupTabBarItemStyle(to: homeVC)
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    private func createSearchNC() -> UIViewController {
        let searchVC = SearchVC(contentView: SearchView(), viewModel: SearchViewModel(), flowDelegate: flowDelegate)
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: .mwlSearch, tag: 1)
        setupTabBarItemStyle(to: searchVC)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    private func createFavoritesNC() -> UIViewController {
        let favoritesVC = FavoritesPageViewVC(flowDelegate: flowDelegate)
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: .mwlHeart, tag: 2)
        setupTabBarItemStyle(to: favoritesVC)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
    private func createWatchListNC() -> UIViewController {
        let favoritesVC = WatchListPageViewVC(flowDelegate: flowDelegate)
        favoritesVC.title = "WatchList"
        favoritesVC.tabBarItem = UITabBarItem(title: "WatchList", image: .mwlWishList, tag: 3)
        setupTabBarItemStyle(to: favoritesVC)
        return UINavigationController(rootViewController: favoritesVC)
    }
    
    
    private func createProfileNC() -> UIViewController {
        let profileVC = ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
        profileVC.flowDelegate = flowDelegate
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: .mwlProfile, tag: 4)
        setupTabBarItemStyle(to: profileVC)
        return UINavigationController(rootViewController: profileVC)
    }
    

    private func setupTabBarItemStyle(to viewController: UIViewController) {
        let attributtedString = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        viewController.tabBarItem.setTitleTextAttributes(attributtedString, for: .normal)
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        viewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8)
    }
    
    
    func setSelectedIndex(index: Int){
        selectedIndex = index
    }
    
}
