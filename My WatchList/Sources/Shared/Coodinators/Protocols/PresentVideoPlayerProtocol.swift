//
//  PresentViewPlayerProtocol.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation
import UIKit

protocol PresentVideoPlayerProtocol: AnyObject {
    func presentVideoPlayer(for video: Video, with currentViewController: UIViewController)
}
