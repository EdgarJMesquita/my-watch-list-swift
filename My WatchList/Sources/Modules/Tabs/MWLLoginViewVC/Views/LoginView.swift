//
//  LoginView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import Foundation
import UIKit
import AuthenticationServices

class LoginView: UIView {
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = .mwlLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlTitle.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        label.text = """
        Hey there, this app uses TMDB to show movies, tv shows and persons.
            
        In order to fully use the features you need to login with TMDB Website.
        
        - Favorite movies and TVs.
        - Add movie or TV to your watchlist
        - Rate movies and TV shows.
        """
        return label
    }()
    
    lazy var actionButton: MWLButton = {
        let button = MWLButton(title: "Login with TMDB")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = .mwlBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        addSubviews(
            logoImageView,
            detailsLabel,
            actionButton
        )
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            detailsLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: Metrics.medium),
            detailsLabel.leadingAnchor.constraint(equalTo: actionButton.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor),
            
            actionButton.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: Metrics.large * 2),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.large),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.large),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension LoginView: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        window!
    }
}
