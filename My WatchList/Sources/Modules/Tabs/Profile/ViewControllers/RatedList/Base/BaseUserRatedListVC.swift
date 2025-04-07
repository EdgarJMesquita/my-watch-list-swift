//
//  MWLUserRatedListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 07/04/25.
//

import Foundation
import UIKit

class BaseUserRatedListVC: UIViewController {
    
    
    let viewModel: UserRatedListViewModel
    weak var delegate: MWLUserRatedListDelegate?

    
    let currentIndex: Int

    
    func getTitle() -> String {
        fatalError("getTitle() -> String has not been implemented")
    }
    
    
    func getUserListType() -> UserMediaType {
        fatalError("getUserListType() -> getUserListType has not been implemented")
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
    
    init(viewModel: UserRatedListViewModel, delegate: MWLUserRatedListDelegate? = nil, currentIndex: Int) {
        self.viewModel = viewModel
        self.delegate = delegate
        self.currentIndex = currentIndex
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        loadMovies()
        setupSeeMoreAction()
    }

    
    private func loadMovies(){
        let type = getUserListType()
        viewModel.loadData(type: type)
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
        delegate?.didTapSeeMore()
    }
}


extension BaseUserRatedListVC: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel.items[indexPath.item], currentIndex: currentIndex)
        
        return cell
    }
}

extension BaseUserRatedListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMedia = viewModel.items[indexPath.item]
        delegate?.didTapMedia(media: selectedMedia)
    }
}

extension BaseUserRatedListVC: UserRatedListViewModelDelegate {
    func didUpdateItems() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {
                return
            }
            collectionView.reloadData()
            
            if viewModel.items.isEmpty {
                collectionView.setEmptyMessage("No data")
            } else {
                collectionView.clearEmptyMessage()
            }
        }
    }
}


protocol MWLUserRatedListDelegate: AnyObject {
    func didTapMedia(media: Media)
    func didTapSeeMore()
}
