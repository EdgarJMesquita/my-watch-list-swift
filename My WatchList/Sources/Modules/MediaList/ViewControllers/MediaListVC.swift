//
//  MediaListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 05/04/25.
//

import Foundation
import UIKit
import Hero

class MediaListVC: UIViewController {
    
    
    let currentIndex: Int
    let contentView: MediaListView
    let viewModel: MediaListViewModel
    weak var flowDelegate: MediaListFlowDelegate?
    
    
    enum Section {
        case main
    }
    
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Media>?
    
    
    init(contentView: MediaListView, viewModel: MediaListViewModel, flowDelegate: MediaListFlowDelegate? = nil, currentIndex:Int) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        self.currentIndex = currentIndex
        
        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
        hero.isEnabled = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        configureDataSource()
        configureSearchController()
        bindCollectionView()
        viewModel.initialLoad()
        view.backgroundColor = .mwlBackground
    }
    
    
    private func configureSearchController(){
        navigationController?.isNavigationBarHidden = false
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Movie, TV or Person"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: contentView.collectionView)
        { collectionView, indexPath, media in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWLSearchResultCollectionViewCell.identifier, for: indexPath) as? MWLSearchResultCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(with: media, currentIndex: 2)
            return cell
        }
        
    }
    
    
    private func updateData(on favorites:[Media]){
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,Media>()
            snapshot.appendSections([.main])
            snapshot.appendItems(favorites)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func bindCollectionView(){
        contentView.collectionView.delegate = self
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.isSearching && viewModel.activeMedias.isEmpty {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        } else if viewModel.isLoading {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    
}


extension MediaListVC: MediaListViewModelDelegate {
    
    
    func viewModel(isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    
    func viewModel(medias: [Media]) {
        DispatchQueue.main.async { [weak self] in
            self?.updateData(on: medias)
            self?.setNeedsUpdateContentUnavailableConfiguration()
        }
    }
    
    
}


extension MediaListVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = viewModel.getMediaAtIndex(indexPath.item)
        
        flowDelegate?.presentShowDetails(
            id: media.id,
            posterPath: media.getImagePath(),
            type: media.getType()
        )
   
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.loadMore()
        }
    }
    
    
}


extension MediaListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.onSearch(for: searchController)
    }
    
}


#Preview {
    MediaListVC(contentView: MediaListView(), viewModel: MediaListViewModel(tmdbType: .movie, tmdbCategory: .popular), currentIndex: 2)
}
