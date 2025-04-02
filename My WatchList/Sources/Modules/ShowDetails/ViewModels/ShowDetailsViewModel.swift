//
//  DetailsViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/03/25.
//

import UIKit

class ShowDetailsViewModel {
    
    weak var delegate: DetailsViewModelDelegate?
    public private(set) var isFavorite = false
    public private(set) var isWatchList = false
    public private(set) var details: ShowDetails?
    private let tmdbService: ShowDetailsService
    private(set) var mediaStates: MediaStates?

    
    init(delegate: DetailsViewModelDelegate? = nil) {
        self.tmdbService = ShowDetailsService()
        self.delegate = delegate
    }
    
    func loadData(id: Int, type: TMDBType){
        
        Task {
            details = try await tmdbService.getShowDetails(for: id, type: type)
            delegate?.detailsDidLoad()
        }
        
        Task {
            guard PersistenceManager.getSessionId() != nil else {
                return
            }
            let states = try await tmdbService.getMediaStatus(mediaId: id, type: type)
            isFavorite = states.favorite
            isWatchList = states.watchlist
            delegate?.isFavoriteDidLoad(isFavorite: isFavorite)
            delegate?.isWatchListDidLoad(isWatchList: isWatchList)
        }
        
    }
    
    
    func toogleFavorite() {
        guard 
            let details = self.details,
            let accountId = PersistenceManager.getInt(key: .accountId),
            PersistenceManager.getSessionId() != nil
        else {
            return
        }
        
        Task {
            do {
                isFavorite.toggle()
                delegate?.isFavoriteDidLoad(isFavorite: isFavorite)
                try await tmdbService.updateMediaFavorite(
                    accountId: accountId,
                    mediaId: details.id,
                    mediaType: details.getType(),
                    favorite: isFavorite
                )
            } catch {
                print(error)
            }
   
        }
        
    }
    
    func toogleWatchList() {
        guard
            let details = self.details,
            let accountId = PersistenceManager.getInt(key: .accountId)
        else {
            return
        }
        
        Task {
            do {
                isWatchList.toggle()
                delegate?.isWatchListDidLoad(isWatchList: isWatchList)
                try await tmdbService.updateMediaWatchList(
                    accountId: accountId,
                    mediaId: details.id,
                    mediaType: details.getType(),
                    watchList: isWatchList
                )
            } catch {
                print(error)
            }
   
        }
        
    }
    
    
}

protocol DetailsViewModelDelegate: AnyObject {
    func detailsDidLoad()
    func isFavoriteDidLoad(isFavorite: Bool)
    func isWatchListDidLoad(isWatchList: Bool)
}
