//
//  MWLSearchResultCollectionViewCell.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//


import UIKit

class MWLSearchResultCollectionViewCell: UICollectionViewCell {
    static let identifier = "MWLSearchResultCollectionViewCell"
    private var hasGradient = false
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        hero.isEnabled = true
        
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
        voteCountIcon.alpha = 1
        voteCountLabel.text = nil
    }
    
    func configure(with show: Media, currentIndex: Int){
        titleLabel.text = show.getTitle()
        
        if let voteCount = show.voteCount?.formatBigNumbers() {
            voteCountLabel.text = voteCount
        } else {
            voteCountIcon.alpha = 0
        }

        
        if let imagePath = show.getImagePath() {
            imageView.hero.id = "\(currentIndex)\(imagePath)"
        }
        
        Task {
            if
                let path = show.getImagePath(),
                let image = await ImageService.shared.downloadTMDBImage(path: path)
            {
                imageView.image = image
                imageView.contentMode = .scaleToFill
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
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.3),
            
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
       
            voteCountIcon.centerYAnchor.constraint(equalTo: voteCountLabel.centerYAnchor),
            voteCountIcon.trailingAnchor.constraint(equalTo: voteCountLabel.leadingAnchor, constant: -3),
            voteCountIcon.heightAnchor.constraint(equalToConstant: 12),
            voteCountIcon.widthAnchor.constraint(equalToConstant: 12),
            
            voteCountLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 6),
            voteCountLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -6),
            
        ])
    }
    
}



//#Preview {
//    HomeVC(contentView: HomeView(),previousIndex: 1)
//}
