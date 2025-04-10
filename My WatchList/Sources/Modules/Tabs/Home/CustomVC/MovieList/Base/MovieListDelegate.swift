//
//  MovieListDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 15/03/25.
//

import Foundation

protocol MovieListDelegate: AnyObject, PresentMediaListProtocol {
    func movieDidTap(show: Media)
}
