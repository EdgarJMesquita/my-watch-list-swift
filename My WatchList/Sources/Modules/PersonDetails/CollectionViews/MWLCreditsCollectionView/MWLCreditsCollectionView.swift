//
//  MWLCreditsCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

class MWLCreditsCollectionView: UICollectionView {
    private var shows: [Media] = []
    weak var customDelegate: MWLCredtisCollectionViewDelegate?
    private let currentIndex: Int
    
    
    init(currentIndex: Int){
        self.currentIndex = currentIndex
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 193)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: ShowCollectionViewCell.identifier)
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        delegate = self
        
        setupConstraints()
    }
    
    func configure(with shows: [Media]){
        self.shows = shows
        reloadData()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MWLCreditsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCollectionViewCell.identifier, for: indexPath) as? ShowCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let show = shows[indexPath.item]
        
        cell.configure(with: show, currentIndex: currentIndex)
        
        return cell
    }
}


extension MWLCreditsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = shows[indexPath.item]
        customDelegate?.didTapShow(show: show)
    }
}

protocol MWLCredtisCollectionViewDelegate: AnyObject {
    func didTapShow(show: Media)
}
