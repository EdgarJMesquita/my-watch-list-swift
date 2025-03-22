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
    
    func makeDetailsVC(flowDelegate: ShowDetailsFlowDelegate, show: Show) -> ShowDetailsVC {
        let contentView = ShowDetailsView()
        let viewController = ShowDetailsVC(contentView: contentView, show: show, viewModel: ShowDetailsViewModel(), flowDelegate: flowDelegate)
        return viewController
    }
    
    func makePersonDetailsVC(flowDelegate: PersonDetailsFlowDelegate, personId: Int) -> PersonDetailsVC {
        let contentView = PersonDetailsView()
        let viewController = PersonDetailsVC(
            contentView: contentView,
            personId: personId,
            viewModel: PersonDetailsViewModel(),
            flowDelegate: flowDelegate
        )
        return viewController
    }
    
    func makeVideoPlayerVC(video: Video) -> VideoPlayerVC {
        let viewController = VideoPlayerVC(video: video)
        return viewController
    }
    
    func makeFullScreenImageVC(imagePath: String) -> FullScreenImageViewVC {
        FullScreenImageViewVC(imagePath: imagePath)
    }
}
