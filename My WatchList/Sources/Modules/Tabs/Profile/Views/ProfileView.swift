//
//  ProfileView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import UIKit
import Lottie

class ProfileView: UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.mwlPrimary.cgColor
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
    
    lazy var ratedMovieListContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratedTVListContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(
            avatarImageView,
            titleLabel,
            ratedMovieListContainer,
            ratedTVListContainer
        )
    }
    
    private func setupConstraints(){
        let movieListHeight: CGFloat = 244
        
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 2 * 430),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 150),
            avatarImageView.widthAnchor.constraint(equalToConstant: 150),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -Metrics.medium),
            
            ratedMovieListContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            ratedMovieListContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratedMovieListContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratedMovieListContainer.heightAnchor.constraint(equalToConstant: movieListHeight),
            
            ratedTVListContainer.topAnchor.constraint(equalTo: ratedMovieListContainer.bottomAnchor, constant: 30),
            ratedTVListContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratedTVListContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            ratedTVListContainer.heightAnchor.constraint(equalToConstant: movieListHeight),
            
        ])
    }
  
}


#Preview {
    ProfileVC(contentView: ProfileView(), viewModel: ProfileViewModel())
}

