//
//  CastCollectionItem.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 17/03/25.
//

import UIKit

class MWLCastViewCell: UICollectionViewCell {
    static let identifier = "MWLCastViewCell"
    weak var delegate: CastViewCellDelegate?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
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
    
    func configure(with cast: Cast){
        nameLabel.text = cast.name

        Task {
            if
                let profilePath = cast.profilePath,
                let image = await ImageService.shared.downloadTMDBImage(path: profilePath)
            {
                avatarImageView.image = image
              
            } else {
                avatarImageView.image = UIImage(systemName: "person.circle.fill")
                avatarImageView.tintColor = .mwlPrimary
            }
        }
        
    }
    
    override func prepareForReuse() {
        nameLabel.text = ""
        avatarImageView.image = nil
    }
    
    private func setup(){
        contentView.addSubview(avatarImageView)
        contentView.addSubview(nameLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

protocol CastViewCellDelegate: AnyObject {
  
}

#Preview {
    DetailsVC(
        contentView: DetailsView(),
        show: Show.buildMock(),
        viewModel: DetailsViewModel()
    )
}
