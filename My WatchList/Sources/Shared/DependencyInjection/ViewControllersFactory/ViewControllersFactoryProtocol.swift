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

    func makeTabBarVC(flowDelegate: TabBarFlowDelegate) -> MWLTabBarController
    
    func makeDetailsVC(flowDelegate: GoBackFlowDelegate, show: Show) -> DetailsVC
}
