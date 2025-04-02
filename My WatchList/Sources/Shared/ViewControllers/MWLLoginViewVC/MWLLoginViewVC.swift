//
//  MWLLoginViewVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import UIKit

class MWLLoginViewVC: UIViewController {

    
    let contentView = LoginView()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
    }
    
    
}

extension MWLLoginViewVC: LoginViewDelegate {
    func didTapActionButton() {
        dismiss(animated: true)
    }
}
