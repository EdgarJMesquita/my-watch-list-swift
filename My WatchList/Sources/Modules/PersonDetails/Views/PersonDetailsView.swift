//
//  PersonDetailsView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import UIKit

class PersonDetailsView: UIView {
    private let previousIndex: Int
    
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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
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
        MWLCreditsCollectionView(currentIndex: previousIndex+1)
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
    
    init(previousIndex: Int) {
        self.previousIndex = previousIndex
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
        
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        [
            titleLabel,
            overviewLabel,
            detailsLabel,
            birthDateLabel,
            placeBirthLabel,
            creditsLabel,
            photosLabel
        ].forEach {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium).isActive = true
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium).isActive = true
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 3 * 430),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            bannerImageView.heightAnchor.constraint(equalToConstant: 200),
            bannerImageView.widthAnchor.constraint(equalToConstant: 200),
            bannerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: Metrics.medium),
            
     
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.medium),

            
            detailsLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Metrics.medium),

            
            birthDateLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: Metrics.small),

            
            placeBirthLabel.topAnchor.constraint(equalTo: birthDateLabel.bottomAnchor, constant: Metrics.small),
            
            creditsLabel.topAnchor.constraint(equalTo: placeBirthLabel.bottomAnchor, constant: Metrics.medium),
            
            creditsCollectionView.topAnchor.constraint(equalTo: creditsLabel.bottomAnchor, constant: Metrics.small),
            creditsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            creditsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
            photosLabel.topAnchor.constraint(equalTo: creditsCollectionView.bottomAnchor, constant: Metrics.medium),
            
            imagesCollectionView.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: Metrics.small),
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
        contentView: PersonDetailsView(previousIndex: 1),
        personId: 2864883,
        profilePath: nil,
        viewModel: PersonDetailsViewModel(),
        previousIndex: 1
    )
}
