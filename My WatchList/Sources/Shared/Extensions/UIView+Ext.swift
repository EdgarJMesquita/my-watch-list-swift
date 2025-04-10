//
//  UIView+Ext.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/02/25.
//

import UIKit

extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
        ])
    }
    
    func addBlurEffect(){
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurView)
    }
    
    
    func addBlurEffect(_ style: UIBlurEffect.Style){
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(blurView)
    }
    
    func addSubviews(_ views: UIView...){
        for view in views { addSubview(view) }
    }
}
