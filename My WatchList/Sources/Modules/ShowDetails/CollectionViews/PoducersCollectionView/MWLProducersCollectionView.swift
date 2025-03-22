//
//  MWLProducersCollectionView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

class MWLProducersCollectionView: UICollectionView {
    private var producers: [ProductionCompany] = []
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.minimumLineSpacing = 8
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        
        register(MWLProducerViewCell.self, forCellWithReuseIdentifier: MWLProducerViewCell.identifier)
 
        translatesAutoresizingMaskIntoConstraints = false
        allowsSelection = false

        dataSource = self
    }
    
    func configure(with producers:[ProductionCompany]){
        self.producers = producers
        reloadData()
    }
    
    func showEmptyMessage(){
        setEmptyMessage("No cast")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MWLProducersCollectionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        producers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MWLProducerViewCell.identifier,
                for: indexPath) as? MWLProducerViewCell
        else {
            return UICollectionViewCell()
        }
        
        let producer = producers[indexPath.item]
        
        cell.configure(imagePath: producer.logoPath, title: producer.name)
        
        return cell
    }
    
}
