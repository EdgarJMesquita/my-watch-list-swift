//
//  RatingView.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/04/25.
//

import UIKit


class RatingView: UIView {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .mwlTitle
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .mwlTitle.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        return label
    }()
    
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .mwlPrimary
        label.font = UIFont.systemFont(ofSize: 130, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    
    lazy var ratingSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 10.0
        slider.minimumTrackTintColor = .mwlPrimary
        slider.thumbTintColor = .mwlSurface
        let rotateTransform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        slider.transform = rotateTransform.translatedBy(
            x: 30,
            y: 80
        )
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    lazy var actionButton: MWLButton = {
        let button = MWLButton(title: "Rate")
        return button
    }()
    
    
    lazy var secondaryButton: MWLButton = {
        let button = MWLButton(title: "Delete rate", color: .red, outlined: true)
        return button
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
    
    
    private func setupHierarchy(){
        addSubviews(
            titleLabel,
            overviewLabel,
            ratingLabel,
            ratingSlider
        )
    }
    
    private func setupConstraints(){
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metrics.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),

            
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -45),
            ratingLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -30),
            

            ratingSlider.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            ratingSlider.heightAnchor.constraint(equalToConstant: 40),
            ratingSlider.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
        ])
    }
    
    
    func setupRateButtonOnly(){
        addSubviews(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupRatedAndDeleteButton(){
        addSubviews(actionButton, secondaryButton)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: secondaryButton.topAnchor, constant: -Metrics.small),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            secondaryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            secondaryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            secondaryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            secondaryButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


#Preview {
    RatingVC(contentView: RatingView(), title: "The Cleaner", initialValue: 5.5, showDelete: false)
}
