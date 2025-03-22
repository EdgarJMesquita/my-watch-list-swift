//
//  PersonDetailsFlowDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

protocol PersonDetailsFlowDelegate: AnyObject, FullScreenImageDelegate {
    func presentShowDetailsDetails(show: Show, with viewController: UIViewController)
//    func presentFullScreenImage(imagePath: String, with viewController: UIViewController)
}

