//
//  MWLReviewCell.swift
//  My WatchList
//
//  Created by Edgar on 12/04/25.
//

import Foundation
import UIKit
import SwiftUI

class MWLReviewViewCell: UICollectionViewCell {
    
    static let identifier = "MWLReviewViewCell"
    
    
    private lazy var avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .mwlPrimary
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var avatarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var reviewContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var favoriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mwlTitle.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 12,weight: .bold)
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
    
    
    private func setup(){
        setupHierarchy()
        setupConstraints()
    }
    
    
    func configure(with review: Review){
        
        let username = review.authorDetails.name.isEmpty ? review.authorDetails.username: review.authorDetails.name

        let date = review.updatedAt.dateFormat(.dateTime.day().month().year())
        let rate = review.authorDetails.rating != nil ? String(review.authorDetails.rating!) : "none"
        let content = review.content
        
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration {
                ReviewViewCell(
                    name: username,
                    content: content,
                    date: date,
                    rate: rate,
                    pathURL: review.authorDetails.avatarPath
                )
            }
            return
        }
      
        avatarLabel.text = username.first?.description.uppercased() ?? "A"
        userLabel.text = username
        
        rateLabel.text = rate
        
        dateLabel.text = date
        
        contentLabel.text = content
        
        if let avatarPath = review.authorDetails.avatarPath {
            Task {
                avatarImageView.image = await ImageService.shared.downloadTMDBImage(path: avatarPath)
            }
        }
    }
    
    
    private func setupHierarchy(){
        contentView.addSubviews(
            avatarView,
            avatarLabel,
            userLabel,
            reviewContent,
            contentLabel,
            dateLabel,
            favoriteImage,
            rateLabel,
            avatarImageView
        )
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.small),
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 40),
            avatarView.widthAnchor.constraint(equalToConstant: 40),
            
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: Metrics.small),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            
            
            avatarLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            avatarLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            
            userLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            userLabel.centerXAnchor.constraint(equalTo: avatarView.centerXAnchor),
            userLabel.widthAnchor.constraint(equalToConstant: 50),
            
            reviewContent.topAnchor.constraint(equalTo: contentView.topAnchor),
            reviewContent.leadingAnchor.constraint(equalTo: userLabel.trailingAnchor, constant: 8),
            reviewContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            reviewContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            favoriteImage.leadingAnchor.constraint(equalTo: reviewContent.leadingAnchor, constant: 8),
            favoriteImage.topAnchor.constraint(equalTo: reviewContent.topAnchor, constant: 8),
            favoriteImage.heightAnchor.constraint(equalToConstant: 14),
            favoriteImage.widthAnchor.constraint(equalToConstant: 14),
            
            rateLabel.leadingAnchor.constraint(equalTo: favoriteImage.trailingAnchor, constant: 2),
            rateLabel.centerYAnchor.constraint(equalTo: favoriteImage.centerYAnchor),
            
            contentLabel.leadingAnchor.constraint(equalTo: reviewContent.leadingAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(equalTo: reviewContent.trailingAnchor, constant: -8),
            contentLabel.topAnchor.constraint(equalTo: favoriteImage.bottomAnchor, constant: 4),
            contentLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -4),
            
            
            dateLabel.bottomAnchor.constraint(equalTo: reviewContent.bottomAnchor, constant: -8),
            dateLabel.trailingAnchor.constraint(equalTo: reviewContent.trailingAnchor,constant: -8)
        ])
    }
    
}


struct ReviewViewCell: View {
    let name: String
    let content: String
    let date: String
    let rate: String
    let pathURL: String?
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                ZStack{
                    Color.mwlPrimary
                    Text(name.uppercased().first?.description ?? "A")
                        .foregroundStyle(.white)
                        .font(.system(size: 14,weight: .bold))
                }
                .frame(width: 40,height: 40)
                .clipShape(Circle())
                .overlay {
                    if
                        let pathURL,
                        let url = URL(string: ImageService.shared.getTMDBURL(path: pathURL))
                    {
                        AsyncImage(url: url ){ image in
                            image.image?.resizable().scaledToFill()
                        }
                        .frame(width: 40,height: 40)
                        .clipShape(Circle())
                    }
                }
                
                Text(name)
                    .lineLimit(3)
                    .font(.system(size: 10))
                    .frame(width: 50)
                    .multilineTextAlignment(.center)
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 2) {
                        Image(systemName:"star.fill" )
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 12,height: 12)
                        Text(rate)
                            .font(.system(size: 10,weight: .bold))
                            .foregroundStyle(.mwlTitle.opacity(0.7))
                           
                    }
                    Text(content)
                        .font(.system(size: 10))
                        .lineLimit(5)
                    HStack {
                        Spacer()
                        Text(date)
                        .font(.system(size: 10))
                    }
                }
                .padding(8)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.2), radius: 4, x: 0, y: 2)
            
        }
        .frame(height: 100)
    }
}

#Preview {
    MWLReviewViewCell()
}
