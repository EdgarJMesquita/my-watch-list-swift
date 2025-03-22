//
//  MWLVideosCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 18/03/25.
//


import UIKit

class MWLVideosCollectionView: UICollectionView {
    private var videos: [Video] = []
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLThumbViewCell.self, forCellWithReuseIdentifier: MWLThumbViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = self
    }
    
    func configure(with videos:[Video]){
        self.videos = videos
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MWLVideosCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MWLThumbViewCell.identifier,
                for: indexPath) as? MWLThumbViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: videos[indexPath.item])
        
        return cell
    }
    
}

