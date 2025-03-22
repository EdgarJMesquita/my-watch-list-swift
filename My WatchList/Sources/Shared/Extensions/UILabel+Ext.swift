//
//  UILabel+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

extension UILabel {
    func countLabelLines() -> Int {
        guard let myText = self.text as? NSString else {
            return 0
        }
       
        let attributes = [NSAttributedString.Key.font : self.font]
       
        let labelSize = myText.boundingRect(with: CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
   }
   
   func isTruncated() -> Bool {
       guard numberOfLines > 0 else { return false }
       return countLabelLines() > numberOfLines
   }
}
