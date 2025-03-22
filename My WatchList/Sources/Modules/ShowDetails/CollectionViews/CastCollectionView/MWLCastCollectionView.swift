//
//  MWLCastCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 18/03/25.
//

import UIKit

class MWLCastCollectionView: UICollectionView {
    private var cast: [Cast] = []
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 70, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLCastViewCell.self, forCellWithReuseIdentifier: MWLCastViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
    }
    
    func configure(with cast:[Cast]){
        self.cast = cast
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MWLCastCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MWLCastViewCell.identifier,
                for: indexPath) as? MWLCastViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: cast[indexPath.item])
        
        return cell
    }
    
}

extension MWLCastCollectionView: UICollectionViewDelegate {
 
}

