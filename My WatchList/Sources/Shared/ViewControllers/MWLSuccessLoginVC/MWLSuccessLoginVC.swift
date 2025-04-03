//
//  MWLSuccessLoginVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import Foundation
import UIKit
import Lottie

class MWLSuccessLoginVC: UIViewController {
    
    
    private lazy var successAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "ConfettiAnimation")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .repeat(10)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.isHidden = true

        return animationView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mwlSurface
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome,"
        return label
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlPrimary
        label.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var actionButton: MWLButton = {
        let button = MWLButton(title: "Start browsing")
        button.addTarget(self, action: #selector(didTapBrowser), for: .touchUpInside)
        return button
    }()
    
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        usernameLabel.text = userName
        view.backgroundColor = .mwlBackground
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        successAnimationView.isHidden = false
        successAnimationView.play()
    }
    
    
    @objc
    private func didTapBrowser(){
        dismiss(animated: true)
    }
    
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    
    private func setupHierarchy(){
        view.addSubviews(
            successAnimationView,
            titleLabel,
            usernameLabel,
            actionButton
        )
    }
    
    
    private func setupConstraints(){
        let padding: CGFloat = 48
        
        NSLayoutConstraint.activate([
            successAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            successAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            successAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            successAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            
            usernameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            usernameLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            actionButton.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
}


#Preview {
    MWLSuccessLoginVC(userName: "Edgar Jonas")
}
