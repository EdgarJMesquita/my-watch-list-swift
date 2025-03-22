//
//  PersonDetailsFlowDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import UIKit

protocol ShowDetailsFlowDelegate: AnyObject, FullScreenImageDelegate, PersonDetailsFlowDelegate {
    func presentPersonDetails(for personId: Int, with viewController: UIViewController)
    func presentVideoPlayer(for video: Video, with viewController: UIViewController)
}
