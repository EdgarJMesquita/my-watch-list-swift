//
//  Exceptions.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import Foundation

enum MWLError: String, Error {
    case missingConfigFile = "Missing Client Id"
    case invalidURL = "URL Inválida"
    case invalidResponse = "Invalid response from server"
}
