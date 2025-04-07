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
        setup()
        handleAuth()
    }
    
    
    private func setup(){
        tabBar.barTintColor = .mwlSurface
        tabBar.isTranslucent = false
        tabBar.tintColor = .mwlPrimary
        tabBar.unselectedItemTintColor = .white
        tabBar.barStyle = .default
    }
    
    
    private func handleAuth(){
        if PersistenceManager.getSessionId() == nil {
            viewControllers = [
                createHomeNC(),
                createSearchNC(),
                createLoginNC()
            ]
        } else {
            viewControllers = [
                createHomeNC(),
                createSearchNC(),
                createFavoritesNC(),
                createWatchListNC(),
                createProfileNC()
            ]
            
            addCornerRadiusToLastTabItem()
        }
     
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
        
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: PersistenceManager.getAvatar(), tag: 4)
        
        setupTabBarItemStyle(to: profileVC)
        return UINavigationController(rootViewController: profileVC)
    }
    
    
    private func createLoginNC() -> UIViewController {
        let loginVC = LoginVC(contentView: LoginView(), viewModel: LoginViewModel(), flowDelegate: flowDelegate)
        loginVC.flowDelegate = flowDelegate
        loginVC.title = "Profile"
        loginVC.tabBarItem = UITabBarItem(title: "Profile", image: .mwlProfile, tag: 4)
        setupTabBarItemStyle(to: loginVC)
        return UINavigationController(rootViewController: loginVC)
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
    
    
    func addCornerRadiusToLastTabItem(){
        if let imageView = tabBar.subviews.last?.subviews.first as? UIImageView {
            imageView.layer.cornerRadius = 12
            imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.mwlPrimary.cgColor
        }
    }
    
    
}
