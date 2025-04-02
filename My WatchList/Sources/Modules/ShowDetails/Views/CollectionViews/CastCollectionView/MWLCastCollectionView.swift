//
//  MWLCastCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 18/03/25.
//

import UIKit

class MWLCastCollectionView: UICollectionView {
    private var cast: [Cast] = []
    weak var customDelegate: MWLCastCollectionViewDelegate?
    let currentIndex: Int
    
    init(currentIndex: Int){
        self.currentIndex = currentIndex
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 120)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLCastViewCell.self, forCellWithReuseIdentifier: MWLCastViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        allowsSelection = true
        delegate = self
        dataSource = self
    }
    
    func configure(with cast:[Cast]){
        self.cast = cast
        reloadData()
    }
    
    func showEmptyMessage(){
        setEmptyMessage("No cast")
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
        
        let cast = cast[indexPath.item]
        
        
        
        let title = if let caracter = cast.character {
            "\(cast.name) (\(caracter))"
        } else {
            cast.name
        }
        
        cell.configure(imagePath: cast.profilePath, title: title, currentIndex: currentIndex)
        
        return cell
    }
    
}

protocol MWLCastCollectionViewDelegate: AnyObject {
    func didSelectCast(personId: Int, profilePath: String?)
}

extension MWLCastCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cast = cast[indexPath.item]
        customDelegate?.didSelectCast(personId: cast.id, profilePath: cast.profilePath)
    }
}

