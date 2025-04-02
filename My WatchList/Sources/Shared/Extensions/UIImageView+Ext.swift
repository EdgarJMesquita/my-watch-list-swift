//
//  UIImageView+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

extension UIImageView {

    func addFadingFooter() {
        let fadeHeihgt: CGFloat = 200
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: frame.height - fadeHeihgt, width: frame.width, height: fadeHeihgt)

        gradientLayer.colors = [
            UIColor.mwlBackground.cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.8).cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.5).cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor
        ]

        gradientLayer.locations = [0.0, 0.2, 0.4, 0.52, 1.0]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        layer.addSublayer(gradientLayer)
    }
    
    func addFadingHeader() {
        let fadeHeight: CGFloat = 100
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: fadeHeight)

        gradientLayer.colors = [
            UIColor.mwlBackground.cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.8).cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.5).cgColor,
            UIColor.mwlBackground.withAlphaComponent(0.2).cgColor,
            UIColor.clear.cgColor
        ]

        gradientLayer.locations = [0.0, 0.2, 0.4, 0.52, 1.0]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.addSublayer(gradientLayer)
    }
    
    func addDarkerOnTopRightEdge() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

      
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.1).cgColor,
            UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor,

        ]

        gradientLayer.locations = [0.0,0.7, 0.8, 1.0]

 
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)

        layer.addSublayer(gradientLayer)
   
    }
}
