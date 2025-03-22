//
//  UICollectionView+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

extension UICollectionView {
    func setEmptyMessage(_ message: String){
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .mwlTitle
        
        backgroundView = UIView()
        
        backgroundView?.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 24),
        ])
    }
    
    func clearEmptyMessage(){
        guard let view = backgroundView else {
            return
        }
        
        view.subviews.forEach {
            $0.removeFromSuperview()
        }
        
        backgroundView = nil
    }
}
