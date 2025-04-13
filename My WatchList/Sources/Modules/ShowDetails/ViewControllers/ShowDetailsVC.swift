//
//  DetailsVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 09/03/25.
//

import UIKit
import Hero

class ShowDetailsVC: UIViewController {
    private let contentView: ShowDetailsView
    private let id: Int
    private let posterPath: String?
    private let type: TMDBType
    private let viewModel: ShowDetailsViewModel
    weak var flowDelegate: ShowDetailsFlowDelegate?
    let previousIndex: Int
    
    init(
        contentView: ShowDetailsView,
        id: Int,
        posterPath: String?,
        type: TMDBType,
        viewModel: ShowDetailsViewModel,
        flowDelegate: ShowDetailsFlowDelegate? = nil,
        previousIndex: Int
    ) {
      
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        self.previousIndex = previousIndex
        self.id = id
        self.posterPath = posterPath
        self.type = type
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
        contentView.castCollectionView.customDelegate = self
        
        self.hero.isEnabled = true
        
        if let posterPath = posterPath {
            self.contentView.bannerImageView.hero.id = "\(previousIndex)\(posterPath)"
        }
      
        setupBanner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
    }
    
    private func setupNavigationItem(title: String){
        navigationItem.backButtonTitle = title
    }
    
    private func setup() {
        view.backgroundColor = .mwlBackground
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView, safe: false)
        configureButtonActions()
    }
    
    private func setupBanner(){
        Task {
            guard
                let posterPath = posterPath,
                let image = await ImageService.shared.downloadTMDBImage(path: posterPath)
            else {
                return
            }
            contentView.bannerImageView.image = image
            contentView.bannerImageView.addFadingFooter()
            
        }
    }
    
    private func loadData(){
        viewModel.loadData(id: id, type: type)
    }
    
    private func setupFavorite(isFavorite: Bool){
        let imageIcon = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        
        let favoriteButton = UIBarButtonItem(image: imageIcon, style: .plain, target: self, action: #selector(didTapFavorite))

        favoriteButton.tintColor = .red
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            navigationItem.rightBarButtonItem = favoriteButton
        }
        
    }
    
    @objc
    private func didTapFavorite(){
        viewModel.toogleFavorite()
    }
    
    private func configureButtonActions(){
        contentView.wishListButton.addTarget(
            self,
            action: #selector(didTapWatchList),
            for: .touchUpInside
        )
        contentView.rateButton.addTarget(
            self,
            action: #selector(didTapRatingButton),
            for: .touchUpInside
        )
    }
    
    private func setupWatchListButton(isWatchList: Bool){
        let buttonTitle = isWatchList ? "- WatchList" : "+ WatchList"
        DispatchQueue.main.async { [weak self] in
            self?.contentView.wishListButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    @objc
    private func didTapWatchList(){
        if PersistenceManager.getSessionId() == nil {
            flowDelegate?.presentLogin()
        } else {
            viewModel.toogleWatchList()
        }
    }
    
    private func setupRatingBottom(rate: Float?){
        if let rate {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                let title = "\(rate)"
                let image = UIImage(systemName: "star.fill")
                contentView.rateButton.setImage(image, for: .normal)
                contentView.rateButton.setTitle(" \(title)", for: .normal)
                contentView.tintColor = .white
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                contentView.rateButton.setTitle("Give a rate", for: .normal)
                contentView.rateButton.setImage(nil, for: .normal)
            }
        }
    }
    
    @objc
    private func didTapRatingButton(){
        if PersistenceManager.getSessionId() == nil {
            flowDelegate?.presentLogin()
        } else {
            let title = "Add rating to\"\(viewModel.details?.getTitle() ?? "Unknown")\""
            let viewController = RatingVC(
                contentView: RatingView(),
                title: title,
                initialValue: viewModel.rate ?? 0.0,
                showDelete: viewModel.rate != nil
            )
            viewController.delegate = self
            present(viewController, animated: true)
        }
    }
    
    private func setupDetails(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            setupTitle()
            setupOverview()
            setupVoteCount()
            setupGenres()
            setupCountries()
            setupDuration()
            setupSpokenLanguages()
            setupCast()
            setupProducers()
            setupImages()
            setupVideos()
            setupRecommendations()
            setupReviews()
            contentView.activityIndicator.stopAnimating()
        }
    }
    
    private func setupTitle(){
        let title = viewModel.details?.getTitle() ?? "Unknown"
        let year = viewModel.details?.releaseDate?.dateFormat(.dateTime.year()) ?? "Unknown"
        contentView.titleLabel.text = "\(title) (\(year))"
        contentView.overviewLabel.text = viewModel.details?.overview
        setupNavigationItem(title: title)
    }
    
    private func setupOverview(){
        contentView.overviewLabel.text = viewModel.details?.overview

        if contentView.overviewLabel.isTruncated() {
            contentView.overviewLabel.isUserInteractionEnabled = true
            let tapRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(presentOverview)
            )
            contentView.overviewLabel.addGestureRecognizer(tapRecognizer)
        }
        
    }
    
    private func setupGenres(){
        let genresString = viewModel.details?.genres.map { $0.name }.joined(separator: ", ")
        contentView.genresLabel.text = "Genre: \(genresString ?? "")"
    }
    
    private func setupVoteCount(){
        guard let voteCount = viewModel.details?.voteAverage else {
            return
        }
        contentView.voteCountLabel.text = "Average: \(voteCount)"
    }
    
    private func setupCountries(){
        let countryString = viewModel.details?.originCountry.joined(separator: ", ")
        contentView.countryLabel.text = "Country: \(countryString ?? "")"
    }
    
    private func setupDuration(){
        guard let durationInMinutes = viewModel.details?.runtime else {
            contentView.durationLabel.text = "Duration: Unknown"
            return
        }
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
    
    private func setupSpokenLanguages(){
        guard let spokenLanguages = viewModel.details?.spokenLanguages else {
            contentView.spokenLanguageLabel.text = "Languages: Unknown"
            return
        }
    
        let spokenLanguageText = spokenLanguages.map { $0.englishName }.joined(separator: ", ")
        
        contentView.spokenLanguageLabel.text = "Languages: \(spokenLanguageText) "
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
            let videos = viewModel.details?.videos?.results,
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
    
    private func setupReviews(){
        guard
            let reviews = viewModel.details?.reviews?.results,
            reviews.count > 0
        else {
            contentView.reviewsCollectionView.setEmptyMessage("No reviews")
            return
        }
        contentView.reviewsCollectionView.customDelegate = self
        contentView.reviewsCollectionView.configure(with: reviews)
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
    func didLoadStates(isWatchList: Bool) {
        setupWatchListButton(isWatchList: isWatchList)
    }
    
    func didLoadStates(isFavorite: Bool) {
        setupFavorite(isFavorite: isFavorite)
    }
    
    func detailsDidLoad() {
        setupDetails()
    }
    
    func didLoadStates(rate: Float?) {
        setupRatingBottom(rate: rate)
    }
    
}

extension ShowDetailsVC: MWLCastCollectionViewDelegate {
    func didSelectCast(personId: Int, profilePath: String?) {
        flowDelegate?.presentPersonDetails(for: personId, profilePath: profilePath)
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
    func didTapShow(show: Media) {
        flowDelegate?.presentShowDetails(id: show.id, posterPath: show.posterPath, type: show.getType())
    }
}

extension ShowDetailsVC: MWLReviewsCollectionViewDelegate {
    func didTapReview(review: Review) {
        if let url = URL(string: review.url) {
            UIApplication.shared.open(url)
        }
    }
}

extension ShowDetailsVC: RatingVCDelegate {
    func didTapRate(rate: Float) {
        viewModel.rateMovie(rate: rate)
    }
    
    func didTapDelete() {
        viewModel.deleteRate()
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
