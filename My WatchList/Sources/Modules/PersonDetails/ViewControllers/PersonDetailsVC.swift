//
//  PersonDetailsVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import UIKit

class PersonDetailsVC: UIViewController {
    private let contentView: PersonDetailsView
    private let personId: Int
    private let viewModel: PersonDetailsViewModel
    weak var flowDelegate: PersonDetailsFlowDelegate?
    
    init(contentView: PersonDetailsView, personId: Int, viewModel: PersonDetailsViewModel, flowDelegate: PersonDetailsFlowDelegate? = nil) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        self.personId = personId
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        setupNavigationItem()
        bindDelegates()
    }

    private func setupNavigationItem(){
        navigationController?.isNavigationBarHidden = true
        
//        let favoriteButton = UIBarButtonItem(
//            image: UIImage(systemName: "star"),
//            style: .done,
//            target: self,
//            action: #selector(dismissVC)
//        )
//        navigationItem.rightBarButtonItem = favoriteButton
//        
//        let closeButton = UIBarButtonItem(
//            barButtonSystemItem: .close,
//            target: self,
//            action: #selector(dismissVC)
//        )
//        navigationItem.leftBarButtonItem = closeButton
        
    }
    
    @objc
    private func dismissVC(){
        dismiss(animated: true)
    }
    
    private func bindDelegates(){
        contentView.creditsCollectionView.customDelegate = self
    }
    
    private func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
    }
    
    private func setupBanner(){
        Task {
            if
                let posterPath = viewModel.person?.profilePath,
                let image = await ImageService.shared.downloadTMDBImage(path: posterPath)
            {
                contentView.bannerImageView.image = image
            } else {
                contentView.bannerImageView.image = UIImage(systemName: "person.circle.fill")
            }
        }
    }
    
    private func loadData(){
        viewModel.loadData(for: personId)
    }
    
    private func setupUI(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            setupBanner()
            contentView.titleLabel.text = viewModel.person?.name
            contentView.overviewLabel.text = viewModel.person?.biography
            
            let birthday = viewModel.person?.birthday?.dateFormat(
                .dateTime
                    .day()
                    .month(.abbreviated)
                    .year()
            )
            
            contentView.birthDateLabel.text = "Birth: \(birthday ?? "Unknown")"
            contentView.placeBirthLabel.text = viewModel.person?.placeOfBirth ?? "Unknown"
            
            if let credits = viewModel.person?.combinedCredits?.cast {
                contentView.creditsCollectionView.configure(with: credits)
            }
            
            if contentView.overviewLabel.isTruncated() {
                contentView.overviewLabel.isUserInteractionEnabled = true
                let tapRecognizer = UITapGestureRecognizer(
                    target: self,
                    action: #selector(presentOverview)
                )
                contentView.overviewLabel.addGestureRecognizer(tapRecognizer)
            }
            
            if let images = viewModel.person?.images?.profiles  {
                contentView.imagesCollectionView.configure(with: images)
                contentView.imagesCollectionView.customDelegate = self
            } else {
                contentView.imagesCollectionView.showEmptyMessage()
            }
            
            contentView.activityIndicator.stopAnimating()
        }
    }
    
    @objc
    func presentOverview(){
        let alert = UIAlertController(
            title: contentView.titleLabel.text,
            message: contentView.overviewLabel.text,
            preferredStyle: .actionSheet
        )
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}


extension PersonDetailsVC: PersonDetailsViewModelDelegate {
    func detailsDidLoad() {
        setupUI()
    }
}

extension PersonDetailsVC: MWLCredtisCollectionViewDelegate {
    func didTapShow(show: Show) {
        flowDelegate?.presentShowDetailsDetails(show: show, with: self)
    }
}

extension PersonDetailsVC: MWLImagesCollectionViewDelegate {
    func didTapImage(imagePath: String) {
        flowDelegate?.presentFullScreenImage(imagePath: imagePath, with: self)
    }
}

#Preview {
    PersonDetailsVC(
        contentView: PersonDetailsView(),
        personId: 1356210,
        viewModel: PersonDetailsViewModel()
    )
}
