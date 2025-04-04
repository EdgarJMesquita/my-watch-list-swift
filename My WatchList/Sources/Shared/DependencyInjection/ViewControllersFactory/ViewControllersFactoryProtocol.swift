//
//  ViewControllersFactory.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 15/03/25.
//

import Foundation

import Foundation

protocol ViewControllersFactoryProtocol: AnyObject {
    func makeSplashVC(flowDelegate: SplashFlowDelegate) -> SplashVC

    func makeTabBarVC(flowDelegate: TabBarFlowDelegate, previousIndex: Int) -> MWLTabBarController
    
    func makeDetailsVC(
        flowDelegate: ShowDetailsFlowDelegate,
        id: Int,
        posterPath: String?,
        type: TMDBType,
        previousIndex: Int
    ) -> ShowDetailsVC
    
    func makePersonDetailsVC(flowDelegate: PersonDetailsFlowDelegate, personId: Int, profilePath: String?, previousIndex: Int) -> PersonDetailsVC
    
    func makeVideoPlayerVC(video: Video) -> VideoPlayerVC
    
    func makeFullScreenImageVC(imagePath: String) -> FullScreenImageViewVC
    
    func makeSuccessLoginVC(username: String) -> MWLSuccessLoginVC
    
    func makeLoginVC(flowDelegate: TabBarFlowDelegate) -> LoginVC
    
    func makeRatedListPageViewVC(flowDelegate: TabBarFlowDelegate) -> RatedListPageViewVC
}
