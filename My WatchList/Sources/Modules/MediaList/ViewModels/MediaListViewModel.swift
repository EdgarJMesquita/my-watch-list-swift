//
//  MediaListViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 05/04/25.
//

import Foundation
import UIKit

class MediaListViewModel {
    
    private(set) var isLoading = false
    private let service: ShowService
    private(set) var isSearching = false
    
    private var medias: [Media] = []
    private var filtered: [Media] = []
    private var page: Int = 1
    
    private let tmdbType: TMDBType
    private let tmdbCategory: TMDBCategory
    
    weak var delegate: MediaListViewModelDelegate?
    
    var activeMedias: [Media]  {
        isSearching ? filtered : medias
    }
    
    init(tmdbType: TMDBType, tmdbCategory: TMDBCategory) {
        self.tmdbType = tmdbType
        self.tmdbCategory = tmdbCategory
        self.service = ShowService()
    }
    
    func initialLoad(){
        loadMore()
    }
    
    func loadMore(){
        if isLoading {
            return
        }
        
        Task {
            do {
                isLoading = true
                delegate?.viewModel(isLoading: isLoading)
         
                let newMedias = try await service.getShows(type: tmdbType, category: tmdbCategory, page: page)
                medias.append(contentsOf: newMedias)
              
                isLoading = false
                page += 1
                
                delegate?.viewModel(medias: activeMedias)
                delegate?.viewModel(isLoading: isLoading)
            } catch {
                isLoading = false
                delegate?.viewModel(isLoading: isLoading)
            }
        }
        
    }
    
    func onSearch(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filtered.removeAll()
            isSearching = false
            delegate?.viewModel(medias: activeMedias)
            return
        }
        isSearching = true
        
        filtered = medias.filter { $0.getTitle().lowercased().contains(filter.lowercased()) }
        delegate?.viewModel(medias: activeMedias)
    }
    
    func getMediaAtIndex(_ index: Int) -> Media {
        return activeMedias[index]
    }
    
}


protocol MediaListViewModelDelegate: AnyObject {
    func viewModel(isLoading: Bool)
    func viewModel(medias: [Media])
}
