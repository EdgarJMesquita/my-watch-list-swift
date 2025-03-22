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
    private let viewModel: DetailsViewModel
    weak var flowDelegate: GoBackFlowDelegate?
    
    init(contentView: ShowDetailsView, show: Show, viewModel: DetailsViewModel, flowDelegate: GoBackFlowDelegate? = nil) {
        self.show = show
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
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
    }

    private func setupNavigationItem(){
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
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
    
    private func setupUI(){
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            contentView.titleLabel.text = viewModel.details?.getTitle()
            contentView.overviewLabel.text = viewModel.details?.overview
            
            let genresString = viewModel.details?.genres.map { $0.name }.joined(separator: ", ")
            
            contentView.genresLabel.text = "Genre: \(genresString ?? "")"
            
            let countryString = viewModel.details?.originCountry.joined(separator: ", ")
            contentView.countryLabel.text = "Country: \(countryString ?? "")"
            
            if let cast = viewModel.details?.credits.cast {
                contentView.castCollectionView.configure(with: cast)
            }
            
            if 
                let videos = viewModel.details?.videos.results,
                videos.count > 0
            {
                contentView.videosCollectionView.alpha = 1
                contentView.videosLabel.alpha = 1
                contentView.videosCollectionView.configure(with: videos)
            }
            
            contentView.activityIndicator.stopAnimating()
        }
    }
}

extension ShowDetailsVC: DetailsViewModelDelegate {
    func detailsDidLoad() {
        setupUI()
    }
}

extension ShowDetailsVC: CastViewCellDelegate {
 
}

#Preview {
    ShowDetailsVC(
        contentView: ShowDetailsView(), 
        show: Show.buildMock(),
        viewModel: DetailsViewModel()
    )
}
