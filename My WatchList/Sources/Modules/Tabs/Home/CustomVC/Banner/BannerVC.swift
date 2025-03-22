//
//  BannerVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/02/25.
//

import UIKit

class BannerVC: UIViewController {
    
    let viewModel: ShowViewModel
    
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.contentMode = .
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
    
    
    init(viewModel: ShowViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func loadMovies() {
        Task {
            await viewModel.loadData(type: .movie, category: .popular)
        }
    }
    
    private func setupBanner() async {
        guard let path = viewModel.shows.first?.posterPath else {
            return
        }
 
        let image = await viewModel.downloadImage(path: path)
        bannerImageView.image = image
        bannerImageView.addFadingFooter()
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        loadMovies()
    }

    private func setupHierarchy() {
        view.addSubview(bannerImageView)
        view.addSubview(filter)
        
        stackView.addArrangedSubview(myListLabel)
        stackView.addArrangedSubview(exploreLabel)
        view.addSubview(stackView)

        stackButton.addArrangedSubview(wishListButton)
        stackButton.addArrangedSubview(detailsButton)
        view.addSubview(stackButton)
   
    }
    
    
    private func setupConstraints() {
        let padding: CGFloat = 24
        let stackButtonHeight: CGFloat = 48
        
        let bannerHeight: CGFloat = 430
        
        NSLayoutConstraint.activate([

            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: bannerHeight),

            filter.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            filter.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filter.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filter.heightAnchor.constraint(equalToConstant: 47),
            
            stackView.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor,constant: -50),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackButton.heightAnchor.constraint(equalToConstant: stackButtonHeight),
            stackButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: padding),
            
        ])
    }
}

extension BannerVC: ShowViewModelDelegate {
    func showsDidUpdate() {
        Task {
            await setupBanner()
        }
    }
}
