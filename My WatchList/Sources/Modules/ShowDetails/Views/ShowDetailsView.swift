//
//  DetailsView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 09/03/25.
//

import UIKit

class ShowDetailsView: UIView {
    
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
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var castCollectionView: MWLCastCollectionView = {
        MWLCastCollectionView()
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
        let collectionView = MWLCreditsCollectionView()
        return collectionView
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
        contentView.addSubview(genresLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(spokenLanguageLabel)
        contentView.addSubview(countryLabel)
        contentView.addSubview(castLabel)
        contentView.addSubview(castCollectionView)
        contentView.addSubview(producersLabel)
        contentView.addSubview(producersCollectionView)
        contentView.addSubview(videosLabel)
        contentView.addSubview(videosCollectionView)
        contentView.addSubview(imagesLabel)
        contentView.addSubview(imagesCollectionView)
        contentView.addSubview(recommendationsLabel)
        contentView.addSubview(recommendationsCollectionView)
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
            genresLabel,
            countryLabel,
            castLabel,
            producersLabel,
            videosLabel,
            imagesLabel,
            videosLabel,
            durationLabel,
            spokenLanguageLabel,
            recommendationsLabel
        ].forEach {
            $0.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
            $0.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 3 * 600),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 430),
            
            wishListButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -50),
            wishListButton.heightAnchor.constraint(equalToConstant: 48),
            
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: padding),
            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding / 2),

            
            detailsLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: padding),

            
            genresLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: padding / 2),

            
            countryLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: padding / 2),
            
            durationLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: padding / 2),
            
            spokenLanguageLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: padding / 2),

            castLabel.topAnchor.constraint(equalTo: spokenLanguageLabel.bottomAnchor, constant: padding),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: padding / 2),
            castCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            castCollectionView.heightAnchor.constraint(equalToConstant: 120),
            
            
            producersLabel.topAnchor.constraint(equalTo: castCollectionView.bottomAnchor, constant: padding),
            
            producersCollectionView.topAnchor.constraint(equalTo: producersLabel.bottomAnchor, constant: padding / 2),
            
            producersCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            producersCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            producersCollectionView.heightAnchor.constraint(equalToConstant: 90),
            
            
            videosLabel.topAnchor.constraint(equalTo: producersCollectionView.bottomAnchor, constant: padding),
            
            videosCollectionView.topAnchor.constraint(equalTo: videosLabel.bottomAnchor, constant: padding / 2),
            
            videosCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videosCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            
            imagesLabel.topAnchor.constraint(equalTo: videosCollectionView.bottomAnchor, constant: padding),
            
            imagesCollectionView.topAnchor.constraint(equalTo: imagesLabel.bottomAnchor, constant: padding / 2),
            
            imagesCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagesCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imagesCollectionView.heightAnchor.constraint(equalToConstant: 100),
            
            recommendationsLabel.topAnchor.constraint(equalTo: imagesCollectionView.bottomAnchor),
            
            recommendationsCollectionView.topAnchor.constraint(equalTo:recommendationsLabel.bottomAnchor, constant: padding / 2 ),
            recommendationsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recommendationsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
    
}

#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(),
        show: Show.buildMock(),
        viewModel: ShowDetailsViewModel()
    )
}
