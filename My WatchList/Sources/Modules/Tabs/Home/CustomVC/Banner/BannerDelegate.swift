//
//  BannerDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation

protocol BannerDelegate: AnyObject {
    func movieDidTap(show: Media)
    func didFinishLoading()
}
