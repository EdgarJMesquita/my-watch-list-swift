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
        navigationController?.setViewControllers([tabBarController], animated: false)
    }
}

extension MWLFlowCoordinator: TabBarFlowDelegate {
    func navigateToDetails(show: Show) {
        let viewController = viewControllerFactory.makeDetailsVC(flowDelegate: self, show: show)
        let navController = UINavigationController(rootViewController: viewController)

        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = false
        
        navigationController?.present(navController, animated: true)
    }
}

extension MWLFlowCoordinator: ShowDetailsFlowDelegate {
    func presentPersonDetails(for personId: Int, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makePersonDetailsVC(flowDelegate: self, personId: personId)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = false
        
        currentViewController.present(navController, animated: true)
    }
    
    func presentVideoPlayer(for video: Video, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makeVideoPlayerVC(video: video)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = false
        
        currentViewController.present(navController, animated: true)
    }
    
}

extension MWLFlowCoordinator: PersonDetailsFlowDelegate {
    func presentShowDetailsDetails(show: Show, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makeDetailsVC(flowDelegate: self, show: show)
        let navController = UINavigationController(rootViewController: viewController)

        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = false
        
        currentViewController.present(navController, animated: true)
    }
}

extension MWLFlowCoordinator: FullScreenImageDelegate {
    func presentFullScreenImage(imagePath: String, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makeFullScreenImageVC(imagePath: imagePath)
        let navController = UINavigationController(rootViewController: viewController)

        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = true

        currentViewController.present(navController, animated: true)
    }
}

extension MWLFlowCoordinator: GoBackFlowDelegate {
    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
