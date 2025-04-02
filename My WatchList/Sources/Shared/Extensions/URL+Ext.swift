//
//  URL+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation

extension URL {
    func getQueryparams() -> [String:String]? {
        var queryParams: [String:String] = [:]
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            return nil
        }
        
        guard let queryItems = components.queryItems else {
            return nil
        }
        
        for item in queryItems {
            queryParams[item.name] = item.value
        }
       
        return queryParams
    }
}
