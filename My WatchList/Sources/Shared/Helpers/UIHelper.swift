//
//  UIHelper.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation
import UIKit

enum UIHelper {
    
    static func createThreeTableColumnFlowLayout(in view:UIView) -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width
    
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (Metrics.small * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        flowLayout.sectionInset = UIEdgeInsets(top: Metrics.small, left: Metrics.small, bottom: Metrics.small, right: Metrics.small)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth / 0.7 + Metrics.small)
        
        return flowLayout
    }
    
    static func createOneTableColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = UIScreen.main.bounds.width

        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (Metrics.small * 2)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        flowLayout.sectionInset = UIEdgeInsets(top: Metrics.small, left: Metrics.small, bottom: Metrics.small, right: Metrics.small)
        flowLayout.itemSize = CGSize(width: availableWidth, height: 100)
        
        return flowLayout
    }
    
}

