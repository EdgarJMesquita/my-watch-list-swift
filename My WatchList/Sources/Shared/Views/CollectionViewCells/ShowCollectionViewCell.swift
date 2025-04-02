//
//  MovieCell.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 23/02/25.
//

import UIKit
import Hero

class ShowCollectionViewCell: UICollectionViewCell {
    static let identifier = "ShowCollectionViewCell"
    private var hasGradient = false
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .mwlGray
     
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var voteCountIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var voteCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy(){
        contentView.addSubviews(
            imageView,
            titleLabel,
            voteCountIcon,
            voteCountLabel
        )
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        imageView.image = nil
        imageView.hero.id = nil
    }
    
    func configure(with show: Media, currentIndex: Int){
        titleLabel.text = show.getTitle()
        voteCountLabel.text = show.voteCount?.formatBigNumbers()
        
        if let posterPath = show.posterPath {
            imageView.hero.id = "\(currentIndex)\(posterPath)"
        }
        
        Task {
            if 
                let path = show.posterPath,
                let image = await ImageService.shared.downloadTMDBImage(path: path) 
            {
                imageView.image = image
               
                if(self.hasGradient == false){
                    imageView.addDarkerOnTopRightEdge()
                    self.hasGradient = true
                }
            } else {
                imageView.image = UIImage(systemName: "photo.fill")
                imageView.contentMode = .scaleAspectFit
            }
        }
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 170),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
       
            voteCountIcon.centerYAnchor.constraint(equalTo: voteCountLabel.centerYAnchor),
            voteCountIcon.trailingAnchor.constraint(equalTo: voteCountLabel.leadingAnchor, constant: -3),
            voteCountIcon.heightAnchor.constraint(equalToConstant: 12),
            voteCountIcon.widthAnchor.constraint(equalToConstant: 12),
            
            voteCountLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
            voteCountLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -6),
            
        ])
    }
    
}



#Preview {
    HomeVC(contentView: HomeView(),previousIndex: 1)
}
