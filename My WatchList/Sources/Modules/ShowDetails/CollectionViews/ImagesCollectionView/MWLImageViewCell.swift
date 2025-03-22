//
//  MWLImageViewCell.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 20/03/25.
//

import UIKit

class MWLImageViewCell: UICollectionViewCell {
    static let identifier = "MWLImageViewCell"
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with profile: Profile){
        Task {
            if
                let image = await ImageService.shared.downloadTMDBImage(path: profile.filePath)
            {
                photoImageView.image = image
              
            } else {
                photoImageView.image = UIImage(systemName: "person.circle.fill")
                photoImageView.tintColor = .mwlPrimary
            }
        }
        
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    private func setup(){
        contentView.addSubview(photoImageView)

        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}



#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(),
        show: Show.buildMock(),
        viewModel: ShowDetailsViewModel()
    )
}
