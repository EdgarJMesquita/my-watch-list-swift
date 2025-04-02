//
//  PersonDetailsVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import UIKit
import Hero

class PersonDetailsVC: UIViewController {
    private let contentView: PersonDetailsView
    private let personId: Int
    private let profilePath: String?
    private let viewModel: PersonDetailsViewModel
    weak var flowDelegate: PersonDetailsFlowDelegate?
    let previousIndex: Int
    
    init(
        contentView: PersonDetailsView,
        personId: Int,
        profilePath: String?,
        viewModel: PersonDetailsViewModel,
        flowDelegate: PersonDetailsFlowDelegate? = nil,
        previousIndex: Int
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        self.personId = personId
        self.previousIndex = previousIndex
        self.profilePath = profilePath
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        setupHero()
        setupBanner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        bindDelegates()
    }
    
    private func bindDelegates(){
        contentView.creditsCollectionView.customDelegate = self
    }
    
    private func setupHero(){
        if let path = profilePath {
            self.hero.isEnabled = true
            contentView.bannerImageView.hero.id = "\(previousIndex)\(path)"
        }
    }
    
    private func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
    }
    
    private func setupBanner(){
        Task {
            if
                let profilePath = profilePath,
                let image = await ImageService.shared.downloadTMDBImage(path: profilePath)
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
        // TODO: Refactor
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            navigationItem.backButtonTitle = viewModel.person?.name
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
    func didTapShow(show: Media) {
        flowDelegate?.presentShowDetails(id: show.id, posterPath: show.posterPath, type: show.getType())
    }
}

extension PersonDetailsVC: MWLImagesCollectionViewDelegate {
    func didTapImage(imagePath: String) {
        flowDelegate?.presentFullScreenImage(imagePath: imagePath, with: self)
    }
}

#Preview {
    PersonDetailsVC(
        contentView: PersonDetailsView(previousIndex: 1),
        personId: 1356210,
        profilePath: nil,
        viewModel: PersonDetailsViewModel(),
        previousIndex: 1
    )
}
