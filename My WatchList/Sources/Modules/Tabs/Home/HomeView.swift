//
//  HomeView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/02/25.
//

import UIKit

class HomeView: UIView {

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
    
    lazy var bannerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var filter: MWLSegmentedFilter = {
        let filter = MWLSegmentedFilter()
        filter.translatesAutoresizingMaskIntoConstraints = false
        return filter
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var myListLabel: UILabel = {
        let label = UILabel()
        label.text = "My list"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .mwlTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var exploreLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .mwlTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.mwlTitle, for: .normal)
        button.backgroundColor = .mwlPrimary
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var popularMoviesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var popularShowsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var trendingMoviesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var trendingShowsContainer: UIView = {
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
    

    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }

    private func setupHierarchy() {
        contentView.addSubview(bannerContainer)
        
        contentView.addSubview(popularMoviesContainer)
        contentView.addSubview(popularShowsContainer)
        contentView.addSubview(trendingMoviesContainer)
        contentView.addSubview(trendingShowsContainer)
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    
    private func setupConstraints() {
           
        scrollView.pinToEdges(of: self)
        
        contentView.pinToEdges(of: scrollView)
        
        let stackButtonHeight: CGFloat = 48
        
        let bannerHeight: CGFloat = 430
        let movieListHeight: CGFloat = 244
        let movieListSpacing: CGFloat = 32
        
        let containers = [
            popularMoviesContainer,
            popularShowsContainer,
            trendingMoviesContainer,
            trendingShowsContainer
        ]
        
        
        let moviesShowsSectionHeight:CGFloat = (movieListHeight + movieListSpacing) * CGFloat(integerLiteral: containers.count) + 100
        
        let contentHeight: CGFloat = bannerHeight + (stackButtonHeight - 3) + moviesShowsSectionHeight
    
        
        containers.forEach { containerView in
            NSLayoutConstraint.activate([
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                containerView.heightAnchor.constraint(equalToConstant: movieListHeight),
            ])
        }
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: contentHeight),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            bannerContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerContainer.heightAnchor.constraint(equalToConstant: bannerHeight),
            
            popularMoviesContainer.topAnchor.constraint(equalTo: bannerContainer.bottomAnchor, constant: movieListSpacing),
            
            popularShowsContainer.topAnchor.constraint(equalTo: popularMoviesContainer.bottomAnchor, constant: movieListSpacing),
            
            trendingMoviesContainer.topAnchor.constraint(equalTo: popularShowsContainer.bottomAnchor, constant: movieListSpacing),
            
            trendingShowsContainer.topAnchor.constraint(equalTo: trendingMoviesContainer.bottomAnchor, constant: movieListSpacing),

        ])
    }

}

#Preview {
    HomeVC(contentView: HomeView())
}
