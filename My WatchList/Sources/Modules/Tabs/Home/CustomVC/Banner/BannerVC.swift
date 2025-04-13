//
//  BannerVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/02/25.
//

import UIKit

class BannerVC: UIViewController {
    
    
    let viewModel: BannerViewModel
    weak var delegate: BannerDelegate?
    weak var flowDelegate: TabBarFlowDelegate?
    let currentIndex: Int
    var timer: Timer?
    
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private lazy var stackButton: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        stackView.isLayoutMarginsRelativeArrangement = true
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
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private lazy var detailsButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Details", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .mwlPrimary
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDetails), for: .touchUpInside)
        return button
    }()
    
    
    init(viewModel: BannerViewModel, currentIndex: Int, delegate: BannerDelegate, flowDelegate: TabBarFlowDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.currentIndex = currentIndex
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc
    private func didTapDetails(){
        guard let show = viewModel.details else {
            return
        }
        delegate?.movieDidTap(show: show)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { [weak self] _ in
            self?.viewModel.updateFromListRandomly()
        }
    }

    
    private func loadMovies() {
        Task {
            await viewModel.loadData(type: .movie, category: .popular)
        }
    }
    
    
    private func setupBanner() async {
        guard let path = viewModel.details?.posterPath else {
            return
        }
 
        let image = await ImageService.shared.downloadTMDBImage(path: path)
        bannerImageView.image = image
        bannerImageView.hero.id = "\(currentIndex)\(path)"
        bannerImageView.addFadingFooter()
    }
    
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
        loadMovies()
        configureWatchListButtonAction()
    }
    
    
    private func setupHierarchy() {
        view.addSubview(bannerImageView)
        stackButton.addArrangedSubview(wishListButton)
        stackButton.addArrangedSubview(detailsButton)
        view.addSubview(stackButton)
   
    }
    
    
    private func setupConstraints() {
        let stackButtonHeight: CGFloat = 48
        
        let bannerHeight: CGFloat = 430
        
        NSLayoutConstraint.activate([

            bannerImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: bannerHeight),

            stackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackButton.heightAnchor.constraint(equalToConstant: stackButtonHeight),
            stackButton.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: -Metrics.medium),
        ])
    }
    
    
    private func configureWatchListButtonAction(){
        wishListButton.addTarget(
            self,
            action: #selector(didTapWatchList),
            for: .touchUpInside
        )
    }
    

    @objc
    private func didTapWatchList(){
        if PersistenceManager.getSessionId() == nil {
            flowDelegate?.presentLogin()
        } else {
            viewModel.toogleWatchList()
        }
    }
    
    
    private func setupWatchListButton(isWatchList: Bool){
        let buttonTitle = isWatchList ? "- WatchList" : "+ WatchList"
        DispatchQueue.main.async { [weak self] in
            self?.wishListButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
}

extension BannerVC: BannerViewModelDelegate {
    func isWatchListDidLoad(isWatchList: Bool) {
        setupWatchListButton(isWatchList: isWatchList)
    }
    
    func didLoadDetails() {
        Task {
            await setupBanner()
        }
        delegate?.didFinishLoading()
    }
}
