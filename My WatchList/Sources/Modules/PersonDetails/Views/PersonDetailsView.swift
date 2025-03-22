//
//  PersonDetailsView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import UIKit

class PersonDetailsView: UIView {
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .mwlPrimary
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var wishListButton: UIButton = {
        let button = UIButton()
        button.setTitle("Wishlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mwlSecondaryButton
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.tintColor = .white
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .mwlTitle.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Detalhes"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var birthDateLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var placeBirthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creditsLabel: UILabel = {
        let label = UILabel()
        label.text = "Credits"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var creditsCollectionView: MWLCreditsCollectionView = {
        MWLCreditsCollectionView()
    }()
    
    
    private lazy var photosLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imagesCollectionView: MWLImagesCollectionView = {
        MWLImagesCollectionView()
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoading(){
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        scrollView.addSubview(contentView)
        addSubview(scrollView)
        
        contentView.addSubview(bannerImageView)
        contentView.addSubview(wishListButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(birthDateLabel)
        contentView.addSubview(placeBirthLabel)
        contentView.addSubview(creditsLabel)
        contentView.addSubview(creditsCollectionView)
        contentView.addSubview(photosLabel)
        contentView.addSubview(imagesCollectionView)

    }
    
    private func setupConstraints(){
        let padding: CGFloat = 24
        
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        [
            wishListButton,
            titleLabel,
            overviewLabel,
            detailsLabel,
            birthDateLabel,
            placeBirthLabel,
            creditsLabel,
            photosLabel
        ].forEach {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 3 * 430),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            bannerImageView.heightAnchor.constraint(equalToConstant: 200),
            bannerImageView.widthAnchor.constraint(equalToConstant: 200),
            bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            wishListButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 50),
            wishListButton.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: wishListButton.bottomAnchor, constant: padding),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 2),

            
            detailsLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: padding),

            
            birthDateLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: padding / 2),

            
            placeBirthLabel.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: padding / 2),
            
            creditsLabel.topAnchor.constraint(equalTo: placeBirthLabel.bottomAnchor, constant: padding),
            
            creditsCollectionView.topAnchor.constraint(equalTo: creditsLabel.bottomAnchor, constant: padding / 2),
            creditsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creditsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            photosLabel.topAnchor.constraint(equalTo: creditsCollectionView.bottomAnchor, constant: padding),
            
            imagesCollectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: padding / 2),
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 250),
        ])
    }
}


#Preview {
    
    // 2864883
    // 1356210 - Milly
    PersonDetailsVC(
        contentView: PersonDetailsView(),
        personId: 2864883,
        viewModel: PersonDetailsViewModel()
    )
}
