//
//  DetailsView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 09/03/25.
//

import UIKit

class ShowDetailsView: UIView {
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addFadingFooter()
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
    
    private lazy var stackButton: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var wishListButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Wishlist", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mwlSecondaryButton
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var rateButton: MWLButton = {
        let button = MWLButton(title: "Give a rate", backgroundColor: .mwlPrimary)
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
    
    lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var spokenLanguageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var castCollectionView: MWLCastCollectionView = {
        MWLCastCollectionView(currentIndex: previousIndex + 1)
    }()
    
    lazy var producersLabel: UILabel = {
        let label = UILabel()
        label.text = "Producers"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var producersCollectionView: MWLProducersCollectionView = {
        let collectionView = MWLProducersCollectionView()
        return collectionView
    }()
    
    lazy var videosLabel: UILabel = {
        let label = UILabel()
        label.text = "Videos"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videosCollectionView: MWLVideosCollectionView = {
        let collectionView = MWLVideosCollectionView()
        return collectionView
    }()
    
    lazy var imagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imagesCollectionView: MWLImagesCollectionView = {
        let collectionView = MWLImagesCollectionView()
        return collectionView
    }()
    
    private lazy var recommendationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommendations"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recommendationsCollectionView: MWLCreditsCollectionView = {
        let collectionView = MWLCreditsCollectionView(currentIndex: previousIndex + 1)
        return collectionView
    }()
    
    private lazy var reviewsLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var reviewsCollectionView: MWLReviewsCollectionView = {
        let collectionView = MWLReviewsCollectionView()
        return collectionView
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
        
        stackButton.addArrangedSubview(wishListButton)
        stackButton.addArrangedSubview(rateButton)
        
        contentView.addSubviews(
            bannerImageView,
            stackButton,
            titleLabel,
            overviewLabel,
            detailsLabel,
            genresLabel,
            voteCountLabel,
            durationLabel,
            spokenLanguageLabel,
            countryLabel,
            castLabel,
            castCollectionView,
            producersLabel,
            producersCollectionView,
            videosLabel,
            videosCollectionView,
            imagesLabel,
            imagesCollectionView,
            recommendationsLabel,
            recommendationsCollectionView,
            reviewsLabel,
            reviewsCollectionView
        )
    }
    
    private func setupConstraints(){
        
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        [
            titleLabel,
            overviewLabel, 
            detailsLabel,
            voteCountLabel,
            genresLabel,
            countryLabel,
            castLabel,
            producersLabel,
            videosLabel,
            imagesLabel,
            videosLabel,
            durationLabel,
            spokenLanguageLabel,
            recommendationsLabel,
            reviewsLabel
        ].forEach {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.medium).isActive = true
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.medium).isActive = true
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 3 * 650),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 430),
            
            
            
            stackButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -50),
            stackButton.heightAnchor.constraint(equalToConstant: 48),
            stackButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: Metrics.medium),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),

            
            detailsLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: Metrics.medium),

            voteCountLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: Metrics.small),
            
            genresLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor, constant: Metrics.small),
            
            countryLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: Metrics.small),
            
            durationLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: Metrics.small),
            
            spokenLanguageLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: Metrics.small),

            castLabel.topAnchor.constraint(equalTo: spokenLanguageLabel.bottomAnchor, constant: Metrics.medium),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: Metrics.small),
            castCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 130),
            
            
            producersLabel.topAnchor.constraint(equalTo: castCollectionView.bottomAnchor, constant: Metrics.medium),
            
            producersCollectionView.topAnchor.constraint(equalTo: producersLabel.bottomAnchor, constant: Metrics.small),
            
            producersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            producersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            producersCollectionView.heightAnchor.constraint(equalToConstant: 90),
            
            
            videosLabel.topAnchor.constraint(equalTo: producersCollectionView.bottomAnchor, constant: Metrics.medium),
            
            videosCollectionView.topAnchor.constraint(equalTo: videosLabel.bottomAnchor, constant: Metrics.small),
            
            videosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            
            imagesLabel.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: Metrics.medium),
            
            imagesCollectionView.topAnchor.constraint(equalTo: imagesLabel.bottomAnchor, constant: Metrics.small),
            
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            recommendationsLabel.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor),
            
            recommendationsCollectionView.topAnchor.constraint(equalTo:recommendationsLabel.bottomAnchor, constant: Metrics.small),
            recommendationsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recommendationsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            reviewsLabel.topAnchor.constraint(equalTo: recommendationsCollectionView.bottomAnchor, constant: Metrics.medium),
            
            reviewsCollectionView.topAnchor.constraint(equalTo:reviewsLabel.bottomAnchor, constant: Metrics.small),
            reviewsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            reviewsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            
        ])
    }
    
}

#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(previousIndex: 1),
        id: 1126166,
        posterPath: "/gFFqWsjLjRfipKzlzaYPD097FNC.jpg",
        type: .movie,
        viewModel: ShowDetailsViewModel(),
        previousIndex: 1
    )
}
