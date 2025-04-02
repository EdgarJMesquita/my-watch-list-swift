//
//  MWLButton.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import UIKit

class MWLButton: UIButton {
    
    
    init(title: String, backgroundColor: UIColor, titleColor: UIColor) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setTitleColor(titleColor, for: .normal)
        setup()
    }
    
    convenience init(title: String, backgroundColor: UIColor){
        self.init(title: title, backgroundColor: backgroundColor, titleColor: .white)
    }
    
    convenience init(title: String, titleColor: UIColor){
        self.init(title: title, backgroundColor: .mwlPrimary, titleColor: titleColor)
    }
    
    convenience init(title: String){
        self.init(title: title, backgroundColor: .mwlPrimary, titleColor: .white)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}


