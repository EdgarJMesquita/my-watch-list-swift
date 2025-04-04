//
//  MWLFlowCoordinator.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/02/25.
//

import UIKit
import Hero

class MWLFlowCoordinator {
    var navigationController: UINavigationController?
    let viewControllerFactory: ViewControllersFactory
    var tabBarController: MWLTabBarController?
    
    init() {
        self.viewControllerFactory = ViewControllersFactory()
        navigationController?.navigationBar.tintColor = .mwlPrimary
    }
    
    func start() -> UINavigationController? {
        let viewController = viewControllerFactory.makeSplashVC(flowDelegate: self)
        viewController.flowDelegate = self
        navigationController = UINavigationController(rootViewController: viewController)
        navigationController?.isNavigationBarHidden = true
        navigationController?.hero.isEnabled = true
        navigationController?.isHeroEnabled = true
        UINavigationBar.appearance().tintColor = .mwlPrimary
        return navigationController
    }
    
}

extension MWLFlowCoordinator: SplashFlowDelegate {
    func navigateToHome() {
        let previousIndex = navigationController?.viewControllers.endIndex ?? 0
        tabBarController = viewControllerFactory.makeTabBarVC(flowDelegate: self, previousIndex: previousIndex)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setViewControllers([tabBarController!], animated: false)
    }
}

extension MWLFlowCoordinator: PresentPersonDetailsProtocol {
    func presentPersonDetails(for personId: Int, profilePath:String?) {
        let viewController = viewControllerFactory.makePersonDetailsVC(
            flowDelegate: self,
            personId: personId,
            profilePath: profilePath,
            previousIndex: navigationController?.viewControllers.endIndex ?? 1
        )
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


extension MWLFlowCoordinator: PresentVideoPlayerProtocol {
    func presentVideoPlayer(for video: Video, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makeVideoPlayerVC(video: video)
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = false
        
        currentViewController.present(navController, animated: true)
    }
    
}

extension MWLFlowCoordinator: PresentShowDetailsProtocol {
    func presentShowDetails(id: Int, posterPath: String?,type: TMDBType) {
        let viewController = viewControllerFactory.makeDetailsVC(
            flowDelegate: self,
            id: id,
            posterPath: posterPath,
            type: type,
            previousIndex: navigationController?.viewControllers.endIndex ?? 1
        )
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension MWLFlowCoordinator: FullScreenImageProtocol {
    func presentFullScreenImage(imagePath: String, with currentViewController: UIViewController) {
        let viewController = viewControllerFactory.makeFullScreenImageVC(imagePath: imagePath)
        let navController = UINavigationController(rootViewController: viewController)

        navController.modalPresentationStyle = .pageSheet
        navController.isNavigationBarHidden = true

        currentViewController.present(navController, animated: true)
    }
}

// MARK: DetailsNavigation
extension MWLFlowCoordinator: PersonDetailsFlowDelegate, ShowDetailsFlowDelegate, TabBarFlowDelegate {
    func navigateToTabBarHome() {
        tabBarController?.setSelectedIndex(index: 0)
    }
    
    func navigateToTabBarSearch() {
        tabBarController?.setSelectedIndex(index: 1)
    }
    
    func navigateToRatedListPageView() {
        let viewController = viewControllerFactory.makeRatedListPageViewVC(flowDelegate: self)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: Auth
extension MWLFlowCoordinator: PresentLoginProtocol {
    func presentLogin() {
        let viewController = viewControllerFactory.makeLoginVC(flowDelegate: self)
        navigationController?.present(viewController, animated: true)
    }
    
    func presentLoginSuccess(username: String){
        let viewController = viewControllerFactory.makeSuccessLoginVC(username: username)
        print("presentLoginSuccess")
        navigateToHome()
        navigationController?.dismiss(animated: false)
        navigationController?.present(viewController, animated: true)
    }
    
    func presentLoginFailure(){
        let alertController = UIAlertController(title: "Oops", message: "We couln't log you in.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController?.present(alertController, animated: true)
    }
}

// MARK: Utils
extension MWLFlowCoordinator: ResetAppProtocol {
    func resetApp() {
        tabBarController = viewControllerFactory.makeTabBarVC(flowDelegate: self, previousIndex: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.setViewControllers([tabBarController!], animated: false)
    }
}
