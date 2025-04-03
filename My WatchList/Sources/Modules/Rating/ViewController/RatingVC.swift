//
//  RatingVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/04/25.
//

import UIKit


class RatingVC: UIViewController {
    
    let rate: Float
    let showDelete: Bool
    let contentView: RatingView
    weak var delegate: RatingVCDelegate?
    
    
    init(contentView: RatingView,title: String, initialValue: Float, showDelete: Bool){
        self.contentView = contentView
        self.rate = initialValue
        self.showDelete = showDelete
        super.init(nibName: nil, bundle: nil)
        contentView.titleLabel.text = title
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSlider()
        setupButtonAction()
        setupSecondaryButtonAction()
        contentView.ratingSlider.setValue(rate, animated: true)
        contentView.ratingLabel.text = rate.formatToTMDBRating()
        if showDelete {
            contentView.setupRatedAndDeleteButton()
        } else {
            contentView.setupRateButtonOnly()
        }
    }
    
    
    private func setup(){
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
    }
    
    
    private func setupSlider(){
        contentView.ratingSlider.addTarget(
            self,
            action: #selector(didChangeSlider(_:)),
            for: .valueChanged
        )
    }
    
    
    @objc
    private func didChangeSlider(_ sender: UISlider){
        contentView.ratingLabel.text = sender.value.formatToTMDBRating()
    }
    
    
    private func setupButtonAction(){
        contentView.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    
    private func setupSecondaryButtonAction(){
        contentView.secondaryButton.addTarget(self, action: #selector(didTapSecondaryButton), for: .touchUpInside)
    }
    
    
    @objc
    private func didTapActionButton(){
        delegate?.didTapRate(rate: contentView.ratingSlider.value.roundToNearestHalf())
        dismiss(animated: true)
    }
    
    @objc
    private func didTapSecondaryButton(){
        delegate?.didTapDelete()
        dismiss(animated: true)
    }
    
}

protocol RatingVCDelegate: AnyObject {
    func didTapRate(rate: Float)
    func didTapDelete()
}


#Preview {
    RatingVC(contentView: RatingView(), title: "The Cleaner", initialValue: 5.5, showDelete: false)
}
