//
//  MovieListDelegate.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 15/03/25.
//

import Foundation

protocol MovieListDelegate: AnyObject {
    func movieDidTap(show: Show)
}
