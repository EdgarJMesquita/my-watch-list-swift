//
//  SearchVC.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 21/03/25.
//

import UIKit

class SearchVC: UIViewController {
    let contentView: SearchView
    let viewModel: SearchViewModel
    weak var flowDelegate: TabBarFlowDelegate?
    
    enum Section {
        case main
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Media>?
    
    init(contentView: SearchView, viewModel: SearchViewModel, flowDelegate: TabBarFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
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
        configureSearchController()
        configureDataSource()
        bindCollectionView()
        view.backgroundColor = .mwlBackground
    }
    
    private func bindCollectionView(){
        contentView.collectionView.delegate = self
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
            cellProvider: { collectionView, indexPath, searchResult in
                
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MWLSearchResultCollectionViewCell.identifier,
                    for: indexPath) as? MWLSearchResultCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                
                cell.configure(with: searchResult, currentIndex: 1)
                return cell
                
            })
    }
        
    private func updateData(on searchResults: [Media]){
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section,Media>()
            snapshot.appendSections([.main])
            snapshot.appendItems(searchResults)
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if viewModel.isSearchResultsEmpty {
            contentUnavailableConfiguration = UIContentUnavailableConfiguration.search()
        } else {
            contentUnavailableConfiguration = nil
        }
    }
}

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        viewModel.onSearch(query: query)
    }
}

extension SearchVC: SearchViewModelDelegate {
    func didChangeSearchResults() {
        updateData(on: viewModel.searchResults)
        DispatchQueue.main.async {
            self.setNeedsUpdateContentUnavailableConfiguration()
        }
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchResult = viewModel.searchResults[indexPath.item]
        
        switch searchResult.mediaType {
        case .movie:
            flowDelegate?.presentShowDetails(id: searchResult.id, posterPath: searchResult.posterPath, type: .movie)
        case .tv:
            flowDelegate?.presentShowDetails(id: searchResult.id, posterPath: searchResult.posterPath, type: .tv)
        case .person:
            flowDelegate?.presentPersonDetails(for: searchResult.id, profilePath: searchResult.profilePath)
        case .none:
            print("No media type")
        }
    }
}

#Preview {
    SearchVC(contentView: SearchView(), viewModel: SearchViewModel())
}
