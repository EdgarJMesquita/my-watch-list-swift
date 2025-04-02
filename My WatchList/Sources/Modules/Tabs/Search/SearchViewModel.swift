//
//  SearchViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation

class SearchViewModel {
    public private(set) var isSearching = false
    public private(set) var isSearchResultsEmpty = true
    private let tmdbService: ShowService
    private var task: Task<(), Never>?
    public private(set) var searchResults: [Media] = []
    weak var delegate: SearchViewModelDelegate?
    
    init() {
        self.tmdbService = ShowService()
    }
    
    func onSearch(query: String?){
        guard let query = query, !query.isEmpty else {
            searchResults = []
            delegate?.didChangeSearchResults()
            isSearchResultsEmpty = true
            isSearching = false
            
            if let task = task {
                task.cancel()
            }
            return
        }
        
        if let task = task {
            task.cancel()
        }

       task = Task { [weak self] in
            guard let self else {
                return
            }
            
            do {
                try await Task.sleep(nanoseconds: 300_000_000)
                isSearching = true
                searchResults = try await tmdbService.search(query: query)
                isSearchResultsEmpty = searchResults.isEmpty
                isSearching = false
                delegate?.didChangeSearchResults()
            } catch {
                print(error)
            }
           
        }
        
    }
}

protocol SearchViewModelDelegate: AnyObject {
    func didChangeSearchResults()
}
