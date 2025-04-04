//
//  Int+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 24/03/25.
//

import Foundation

extension Int {
    func formatBigNumbers() -> String {
        let num = Double(self)
        
        let thousand = 1_000.0
        let million = 1_000_000.0
        let billion = 1_000_000_000.0

        let formatted: Double
        let suffix: String

        if num >= billion {
            formatted = floor(num / billion * 10) / 10
            suffix = "B"
        } else if num >= million {
            formatted = floor(num / million * 10) / 10
            suffix = "M"
        } else if num >= thousand {
            formatted = floor(num / thousand * 10) / 10
            suffix = "k"
        } else {
            return "\(Int(num))"
        }

        return formatted.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(formatted))\(suffix)"
            : "\(formatted)\(suffix)"
    }
}
