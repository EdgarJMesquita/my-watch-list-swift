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
    
    func makeTabBarVC(flowDelegate: TabBarFlowDelegate, previousIndex: Int) -> MWLTabBarController {
        let tabBarVC = MWLTabBarController(flowDelegate: flowDelegate, previousIndex: previousIndex)
        return tabBarVC
    }
    
    func makeDetailsVC(
        flowDelegate: ShowDetailsFlowDelegate,
        id: Int,
        posterPath: String?,
        type: TMDBType,
        previousIndex: Int
    ) -> ShowDetailsVC {
        let contentView = ShowDetailsView(previousIndex: previousIndex)
        let viewController = ShowDetailsVC(
            contentView: contentView,
            id: id,
            posterPath: posterPath,
            type: type,
            viewModel: ShowDetailsViewModel(),
            flowDelegate: flowDelegate,
            previousIndex: previousIndex
        )
        return viewController
    }
    
    func makePersonDetailsVC(flowDelegate: PersonDetailsFlowDelegate, personId: Int,profilePath: String?, previousIndex: Int) -> PersonDetailsVC {
        let contentView = PersonDetailsView(previousIndex: previousIndex)
        let viewController = PersonDetailsVC(
            contentView: contentView,
            personId: personId,
            profilePath: profilePath,
            viewModel: PersonDetailsViewModel(),
            flowDelegate: flowDelegate,
            previousIndex: previousIndex
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
    
    func makeSuccessLoginVC(username: String) -> MWLSuccessLoginVC {
        let viewController = MWLSuccessLoginVC(userName: username)
        return viewController
    }
    
}
