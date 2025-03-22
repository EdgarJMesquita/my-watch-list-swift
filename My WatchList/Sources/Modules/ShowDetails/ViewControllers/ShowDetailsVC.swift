//
//  DetailsVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 09/03/25.
//

import UIKit

class ShowDetailsVC: UIViewController {
    private let contentView: ShowDetailsView
    private let show: Show
    private let viewModel: ShowDetailsViewModel
    weak var flowDelegate: ShowDetailsFlowDelegate?
    
    init(contentView: ShowDetailsView, show: Show, viewModel: ShowDetailsViewModel, flowDelegate: ShowDetailsFlowDelegate? = nil) {
        self.show = show
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        contentView.castCollectionView.customDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        setupNavigationItem()
     
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
//        
//        navigationItem.leftBarButtonItem = closeButton
        
    }
    
    @objc
    private func dismissVC(){
        dismiss(animated: true)
    }
    
    private func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
    }
    
    private func setupBanner(){
        Task {
            guard
                let posterPath = show.posterPath,
                let image = await ImageService.shared.downloadTMDBImage(path: posterPath)
            else {
                return
            }
            
            contentView.bannerImageView.image = image
            contentView.bannerImageView.addFadingFooter()
            
        }
    }
    
    private func loadData(){
        setupBanner()
        viewModel.loadData(for: show)
    }
    
    private func setupDetails(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            setupTexts()
            setupCast()
            setupProducers()
            setupImages()
            setupVideos()
            setupRecommendations()
            contentView.activityIndicator.stopAnimating()
        }
    }
    
    private func setupTexts(){
        let title = viewModel.details?.getTitle() ?? "Unknown"
        let year = viewModel.details?.releaseDate?.dateFormat(.dateTime.year()) ?? "Unknown"
        contentView.titleLabel.text = "\(title) (\(year))"
        contentView.overviewLabel.text = viewModel.details?.overview
        
        let genresString = viewModel.details?.genres.map { $0.name }.joined(separator: ", ")
        contentView.genresLabel.text = "Genre: \(genresString ?? "")"
        
        let countryString = viewModel.details?.originCountry.joined(separator: ", ")
        contentView.countryLabel.text = "Country: \(countryString ?? "")"
        
        if let durationInMinutes = viewModel.details?.runtime {
            let hours = durationInMinutes / 60
            let minutes = durationInMinutes % 60
        
            var runtime = "Duration: "
            
            if(hours > 0){
                runtime += "\(hours)h "
            }
            if(minutes > 0){
                runtime += "\(minutes)m "
            }
            
            contentView.durationLabel.text = runtime
        }
        
        if let spokenLanguages = viewModel.details?.spokenLanguages {
            contentView.spokenLanguageLabel.text = "Languages: " + spokenLanguages.map {
                $0.englishName
            }.joined(separator: ", ")
        }
        
        if contentView.overviewLabel.isTruncated() {
            contentView.overviewLabel.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(presentOverview)
            )
            contentView.overviewLabel.addGestureRecognizer(tapRecognizer)
        }
        
    }
    
    private func setupCast(){
        guard 
            let cast = viewModel.details?.credits?.cast,
            cast.count > 0
        else {
            contentView.castCollectionView.showEmptyMessage()
            return
        }
        contentView.castCollectionView.customDelegate = self
        contentView.castCollectionView.configure(with: cast)
    }
    
    private func setupVideos(){
        guard 
            let videos = viewModel.details?.videos.results,
            videos.count > 0
        else {
            contentView.videosCollectionView.showEmptyMessage()
            return
        }
        contentView.videosCollectionView.customDelegate = self
        contentView.videosCollectionView.configure(with: videos)
    }
    
    private func setupImages(){
        guard
            let images = viewModel.details?.images?.profiles,
            images.count > 0
        else {
            contentView.imagesCollectionView.showEmptyMessage()
            return
        }
        contentView.imagesCollectionView.customDelegate = self
        contentView.imagesCollectionView.configure(with: images)
    }
    
    private func setupProducers(){
        guard 
            let producers = viewModel.details?.productionCompanies,
            producers.count > 0
        else {
            contentView.producersCollectionView.showEmptyMessage()
            return
        }
        contentView.producersCollectionView.configure(with: producers)
    }
    
    private func setupRecommendations(){
        guard
            let recommendations = viewModel.details?.recommendations?.results,
            recommendations.count > 0
        else {
            contentView.recommendationsCollectionView.setEmptyMessage("No recommendations")
            return
        }
        contentView.recommendationsCollectionView.customDelegate = self
        contentView.recommendationsCollectionView.configure(with: recommendations)
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

extension ShowDetailsVC: DetailsViewModelDelegate {
    func detailsDidLoad() {
        setupDetails()
    }
}

extension ShowDetailsVC: MWLCastCollectionViewDelegate {
    func didSelectCast(personId: Int) {
        flowDelegate?.presentPersonDetails(for: personId, with: self)
    }
}

extension ShowDetailsVC: MWLVideosColletionViewDelegate {
    func didTapVideo(video: Video) {
        flowDelegate?.presentVideoPlayer(for: video, with: self)
    }
}

extension ShowDetailsVC: MWLImagesCollectionViewDelegate {
    func didTapImage(imagePath: String) {
        flowDelegate?.presentFullScreenImage(imagePath: imagePath, with: self)
    }
}

extension ShowDetailsVC: MWLCredtisCollectionViewDelegate {
    func didTapShow(show: Show) {
        flowDelegate?.presentShowDetailsDetails(show: show, with: self)
    }
}

#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(), 
        show: Show.buildMock(),
        viewModel: ShowDetailsViewModel()
    )
}
