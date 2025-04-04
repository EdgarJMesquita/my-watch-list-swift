//
//  MWLUsersMediaListVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation
import Hero
import UIKit

enum UserMediaType: String {
    case movies = "movies"
    case tv = "tv"
}

class MWLUsersMediaListVC: MWLBaseViewController {
    
    enum Section {
        case main
    }
    
    private var isLoading = true
    
    let contentView: MWLUsersMediaListView
    let viewModel: MWLUsersMediaViewModel
    weak var flowDelegate: TabBarFlowDelegate?
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Media>?

    init(
        contentView: MWLUsersMediaListView,
        viewModel: MWLUsersMediaViewModel,
        title: String,
        flowDelegate: TabBarFlowDelegate? = nil
    ) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        
        viewModel.delegate = self
        self.hero.isEnabled = true
        navigationItem.title = title
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configureSearchController()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func loadFavorites(){
        viewModel.loadData()
    }
    
    private func setup(){
        view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)

        bindCollectionView()
        view.backgroundColor = .mwlBackground
    }
    
    
    private func bindCollectionView(){
        contentView.collectionView.delegate = self
    }
    
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
   
        if isLoading {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.loading()
        }
        
        else if viewModel.activeItems.isEmpty {
            var emptyView = UIContentUnavailableConfiguration.empty()
            emptyView.text = "Empty"
            emptyView.secondaryText = "You can add any \(viewModel.type.rawValue)"
            emptyView.button.title = "Home"
            emptyView.buttonProperties.primaryAction = UIAction.init(handler: { _ in
                self.flowDelegate?.navigateToTabBarHome()
            })
            emptyView.secondaryButton.title = "Search"
            emptyView.secondaryButtonProperties.primaryAction = UIAction.init(handler: { _ in
                self.flowDelegate?.navigateToTabBarSearch()
            })
            contentUnavailableConfiguration = emptyView
            
        } else {
            contentUnavailableConfiguration = nil
        }
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
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: contentView.collectionView,
            cellProvider: { collectionView, indexPath, media in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWLSearchResultCollectionViewCell.identifier, for: indexPath) as? MWLSearchResultCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.configure(with: media, currentIndex: 1)
                return cell
            }
        )
        
    }
    
    private func updateData(on favorites:[Media]){
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,Media>()
            snapshot.appendSections([.main])
            snapshot.appendItems(favorites)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
}



extension MWLUsersMediaListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let media = viewModel.activeItems[indexPath.item]
        
        flowDelegate?.presentShowDetails(
            id: media.id,
            posterPath: media.getImagePath(),
            type: media.getType()
        )
   
    }
}

extension MWLUsersMediaListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.onSearch(for: searchController)
    }
}


extension MWLUsersMediaListVC: MWLUsersMediaViewModelDelegate {
    func didUpdateItems() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            isLoading = false
            setNeedsUpdateContentUnavailableConfiguration()
            updateData(on: viewModel.activeItems)
        }
    }
    func didGetUnauthorized() {
        setNeedsUpdateContentUnavailableConfiguration()
    }
}

//#Preview {
//    MWLUsersMediaListVC(contentView: FavoritesListView(), viewModel: FavoritesViewModel(),type: .movies)
//}
