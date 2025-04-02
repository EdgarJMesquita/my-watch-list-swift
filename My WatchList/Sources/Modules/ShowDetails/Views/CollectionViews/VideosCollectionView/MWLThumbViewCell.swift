//
//  MWLThumbViewCell.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 18/03/25.
//

import UIKit

class MWLThumbViewCell: UICollectionViewCell {
    static let identifier = "MWLThumbViewCell"
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .mwlTitle.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with video: Video){
        nameLabel.text = video.name
        Task {
            if
                let image = await ImageService.shared.downloadThumbnail(for: video)
            {
                avatarImageView.image = image
              
            } else {
                avatarImageView.image = UIImage(systemName: "person.circle.fill")
                avatarImageView.tintColor = .mwlPrimary
            }
        }
        
    }
    
    override func prepareForReuse() {
        avatarImageView.image = nil
    }
    
    private func setup(){
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
        ])
    }
}



#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(previousIndex: 1),
        id: 1126166,
        posterPath: "/gFFqWsjLjRfipKzlzaYPD097FNC.jpg",
        type: .movie,
        viewModel: ShowDetailsViewModel(),
        previousIndex: 1
    )
}
