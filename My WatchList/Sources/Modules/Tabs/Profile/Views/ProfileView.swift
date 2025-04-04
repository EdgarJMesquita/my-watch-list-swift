//
//  ProfileView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import UIKit
import Lottie

class ProfileView: UIView {
    
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var actionButton: MWLButton = {
        let button = MWLButton(title: "My rated movies/shows")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
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
            avatarImageView,
            titleLabel,
            actionButton
        )
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Metrics.medium),
            
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.medium),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
  
}


#Preview {
    ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
}

