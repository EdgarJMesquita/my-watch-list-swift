//
//  MWLFlowCoordinator.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/02/25.
//

import UIKit

class MWLFlowCoordinator {
    var navigationController: UINavigationController?
    
    let viewControllerFactory: ViewControllersFactory

    init() {
        self.viewControllerFactory = ViewControllersFactory()
        navigationController?.navigationBar.tintColor = .mwlPrimary
    }
    
    func start() -> UINavigationController? {
        let viewController = viewControllerFactory.makeSplashVC(flowDelegate: self)
        viewController.flowDelegate = self
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        return navigationController
    }
}

extension MWLFlowCoordinator: SplashFlowDelegate {
    func navigateToHome() {
        let tabBarController = viewControllerFactory.makeTabBarVC(flowDelegate: self)
        navigationController?.setViewControllers([tabBarController], animated: true)
    }
}

extension MWLFlowCoordinator: TabBarFlowDelegate {
    func navigateToDetails(show: Show) {
        let viewController = viewControllerFactory.makeDetailsVC(flowDelegate: self, show: show)
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MWLFlowCoordinator: GoBackFlowDelegate {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
