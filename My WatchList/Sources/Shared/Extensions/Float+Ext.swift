//
//  Float+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/04/25.
//

import Foundation

extension Float {
    func roundToNearestHalf() -> Float {
        return (self * 2).rounded() / 2
    }
    
    func formatToTMDBRating() -> String {
        let value = self.roundToNearestHalf()
        if value == 10.0 || value == 0.0 {
            return String(format: "%.f", value)
        }
        return "\(value)"
    }
}
