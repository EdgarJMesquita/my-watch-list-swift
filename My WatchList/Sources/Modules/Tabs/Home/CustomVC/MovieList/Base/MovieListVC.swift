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

    func getTitle() -> String {
        fatalError("getTitle() -> String has not been implemented")
    }
    
    func getTraktType() -> TMDBType {
        fatalError("getTraktType() -> TraktType has not been implemented")
    }
    
    func getTraktCategory() -> TMDBCategory {
        fatalError("getTraktCategory() -> TraktCategory has not been implemented")
    }
    
    private lazy var titleBabel: UILabel = {
        let label = UILabel()
        label.text = getTitle()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .mwlTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "See more"
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .mwlPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 193)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self

        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: ShowViewModel, delegate: MovieListDelegate? = nil) {
        self.viewModel = viewModel
        self.delegate = delegate
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
    }
    
    private func loadMovies(){
        Task {
            await viewModel.loadData(type: getTraktType(),category:getTraktCategory())
        }
    }
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        view.addSubview(titleBabel)
        view.addSubview(subtitleLabel)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints(){
        let padding: CGFloat = 24
        
        NSLayoutConstraint.activate([
            titleBabel.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            titleBabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            subtitleLabel.centerYAnchor.constraint(equalTo: titleBabel.centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            collectionView.topAnchor.constraint(equalTo: titleBabel.bottomAnchor,constant: padding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 193)
        ])
    }
}


extension MovieListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.shows[indexPath.section])
        cell.imageDownloaderDelegate = self
        
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedShow = viewModel.shows[indexPath.section]
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

extension MovieListVC: ImageDownloaderDelegate {
    func downloadTraktImage(urlString: String) async -> UIImage? {
        await viewModel.downloadImage(path: urlString)
    }
}
