//
//  PresentMediaListProtocol.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 05/04/25.
//

import Foundation

protocol PresentMediaListProtocol: AnyObject {
    func navigateToMediaList(tmdbType: TMDBType, tmdbCategory: TMDBCategory)
}
