//
//  ImagesCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

class MWLImagesCollectionView: UICollectionView {
    private var profiles: [Profile] = []
    weak var customDelegate: MWLImagesCollectionViewDelegate?
        
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: 150, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLImageViewCell.self, forCellWithReuseIdentifier: MWLImageViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        
        dataSource = self
        
        delegate = self
        
    }
        
    func configure(with profiles: [Profile]){
        self.profiles = profiles
        reloadData()
    }
    
    func showEmptyMessage(){
        self.setEmptyMessage("No photos")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MWLImagesCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MWLImageViewCell.identifier,
                for: indexPath) as? MWLImageViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: profiles[indexPath.item])
        
        return cell
    }
    
}

extension MWLImagesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = profiles[indexPath.item]
        let imageRatio = image.aspectRatio
        let height = collectionView.bounds.height
        let width = height * imageRatio

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = profiles[indexPath.item]
        customDelegate?.didTapImage(imagePath: profile.filePath)
    }
}

protocol MWLImagesCollectionViewDelegate: AnyObject {
    func didTapImage(imagePath: String)
}



