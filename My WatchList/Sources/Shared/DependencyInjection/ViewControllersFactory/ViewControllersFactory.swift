//
//  ViewControllersFactory.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 15/03/25.
//

import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
   
    
    func makeSplashVC(flowDelegate: SplashFlowDelegate) -> SplashVC {
        let contentView = SplashView()
        let viewController = SplashVC(contentView: contentView, flowDelegate: flowDelegate)
        return viewController
    }
    
    func makeTabBarVC(flowDelegate: TabBarFlowDelegate) -> MWLTabBarController {
        let tabBarVC = MWLTabBarController(flowDelegate: flowDelegate)
        return tabBarVC
    }
    
    func makeDetailsVC(flowDelegate: GoBackFlowDelegate, show: Show) -> DetailsVC {
        let contentView = DetailsView()
        let viewController = DetailsVC(contentView: contentView, show: show, flowDelegate: flowDelegate)
        return viewController
    }
}
