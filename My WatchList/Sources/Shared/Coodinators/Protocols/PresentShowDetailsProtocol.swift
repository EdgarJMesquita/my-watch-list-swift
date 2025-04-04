//
//  PresentShowDetailsProtocol.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation

protocol PresentShowDetailsProtocol: AnyObject {
    func presentShowDetails(id: Int, posterPath: String?, type: TMDBType)
}
