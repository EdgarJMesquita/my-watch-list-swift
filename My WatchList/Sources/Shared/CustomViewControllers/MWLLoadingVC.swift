//
//  MLWLoadingVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/03/25.
//

import UIKit

class MWLLoadingVC: UIViewController {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mwlBackground.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addBlurEffect()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .mwlPrimary
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
  
    
    func showLoading(){
        setup()
        activityIndicator.startAnimating()
    }
    
    func hideLoading(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        containerView.removeFromSuperview()
    }
    
    private func setup(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        containerView.addSubview(activityIndicator)
        view.addSubview(containerView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
}


protocol MWLLoadingProtocol: AnyObject {
    var contentView: UIView { get }
}
