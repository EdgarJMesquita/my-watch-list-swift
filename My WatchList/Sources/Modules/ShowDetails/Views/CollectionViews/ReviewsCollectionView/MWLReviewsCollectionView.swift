//
//  MWLReviewsCollectionView.swift
//  My WatchList
//
//  Created by Edgar on 12/04/25.
//

import Foundation
import UIKit

class MWLReviewsCollectionView: UICollectionView {
    
    private var reviews: [Review] = []
    weak var customDelegate: MWLReviewsCollectionViewDelegate?
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 250, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLReviewViewCell.self, forCellWithReuseIdentifier: MWLReviewViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        allowsSelection = true
        dataSource = self
        delegate = self
        heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with reviews: [Review]){
        self.reviews = reviews
        reloadData()
    }
    
}


extension MWLReviewsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviews.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWLReviewViewCell.identifier, for: indexPath) as?
        MWLReviewViewCell else {
            return UICollectionViewCell()
        }
        let review = reviews[indexPath.item]
        cell.configure(with: review)
        return cell
    }
    
}


extension MWLReviewsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let review = reviews[indexPath.item]
        customDelegate?.didTapReview(review: review)
    }
    
}


protocol MWLReviewsCollectionViewDelegate: AnyObject {
    
    func didTapReview(review: Review)
    
}

