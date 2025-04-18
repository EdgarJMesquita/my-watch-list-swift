//
//  String+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import Foundation
import UIKit


extension String {
    func dateFormat(_ format: Date.FormatStyle) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self){
            return date.formatted(format)
        }
        
        let iso18DateFormatter = ISO8601DateFormatter()
        iso18DateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        if let date = iso18DateFormatter.date(from: self){
            return date.formatted(format)
        }
      
        
        return "Unknown"
    }
}
