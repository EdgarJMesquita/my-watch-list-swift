//
//  PresentPersonDetailsProtocol.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation

protocol PresentPersonDetailsProtocol: AnyObject {
    func presentPersonDetails(for personId: Int, profilePath:String?)
}
