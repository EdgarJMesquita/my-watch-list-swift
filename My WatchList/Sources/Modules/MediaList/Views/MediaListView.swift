//
//  MediaListView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 05/04/25.
//

import Foundation
import UIKit

class MediaListView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UIHelper.createThreeTableColumnFlowLayout(in: self)
        )
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MWLSearchResultCollectionViewCell.self, forCellWithReuseIdentifier: MWLSearchResultCollectionViewCell.identifier)
        collectionView.allowsSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    
    private func setupHierarchy(){
        addSubviews(collectionView)
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
