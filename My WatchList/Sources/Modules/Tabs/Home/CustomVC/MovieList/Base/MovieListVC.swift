//
//  MovieListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/02/25.
//

import UIKit

class MovieListVC: UIViewController {
    
    let viewModel: ShowViewModel
    weak var delegate: MovieListDelegate?

    let currentIndex: Int

    func getTitle() -> String {
        fatalError("getTitle() -> String has not been implemented")
    }
    
    func getTMDBType() -> TMDBType {
        fatalError("getTMDBType() -> getTMDBType has not been implemented")
    }
    
    func getTMDBCategory() -> TMDBCategory {
        fatalError("getTMDBCategory() -> getTMDBCategory has not been implemented")
    }
    
    private lazy var titleBabel: UILabel = {
        let label = UILabel()
        label.text = getTitle()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .mwlTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "See more"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .mwlPrimary
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 193)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self

        collectionView.delegate = self
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: ShowViewModel, delegate: MovieListDelegate? = nil, currentIndex: Int) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMovies()
        setupSeeMoreAction()
    }
    
    private func loadMovies(){
        let type = getTMDBType()
        let category = getTMDBCategory()
        
        Task {
            await viewModel.loadData(type: type, category: category)
        }
    }
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        view.addSubview(titleBabel)
        view.addSubview(seeMoreLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titleBabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Metrics.medium),
            titleBabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metrics.medium),
            
            seeMoreLabel.centerYAnchor.constraint(equalTo: titleBabel.centerYAnchor),
            seeMoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metrics.medium),
            
            collectionView.topAnchor.constraint(equalTo: titleBabel.bottomAnchor,constant: Metrics.medium),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 193)
        ])
    }
    
    private func setupSeeMoreAction(){
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTapSeeMore))
        seeMoreLabel.addGestureRecognizer(recognizer)
    }
    
    @objc
    private func didTapSeeMore(){
        delegate?.navigateToMediaList(tmdbType: getTMDBType(), tmdbCategory: getTMDBCategory())
    }
}


extension MovieListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.shows[indexPath.item], currentIndex: currentIndex)
        
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedShow = viewModel.shows[indexPath.item]
        delegate?.movieDidTap(show: selectedShow)
    }
}

extension MovieListVC: ShowViewModelDelegate {
    func showsDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}
