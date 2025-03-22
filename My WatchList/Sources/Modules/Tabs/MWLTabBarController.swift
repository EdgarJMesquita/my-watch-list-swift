//
//  File.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class MWLTabBarController: UITabBarController {
    weak var flowDelegate: TabBarFlowDelegate?
    
    init(flowDelegate: TabBarFlowDelegate? = nil) {
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .mwlBackground
        tabBar.isTranslucent = false
        tabBar.tintColor = .mwlPrimary
        tabBar.barStyle = .default

        viewControllers = [createHomeNC()]
    }

    private func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC(contentView: HomeView(),flowDelegate: flowDelegate)
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: .mwlHome, tag: 0)
        setupTabBarItemStyle(to: homeVC)
        return UINavigationController(rootViewController: homeVC)

    }

    private func setupTabBarItemStyle(to viewController: UIViewController) {
        let attributtedString = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ]
        viewController.tabBarItem.setTitleTextAttributes(attributtedString, for: .normal)

        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        viewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 8)
    }
}
