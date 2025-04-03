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
    public private(set) var rate: Float?
    public private(set) var details: ShowDetails?
    public private(set) var mediaId: Int?
    public private(set) var mediaType: TMDBType?
    private let tmdbService: ShowDetailsService
    
    
    init(delegate: DetailsViewModelDelegate? = nil) {
        self.tmdbService = ShowDetailsService()
        self.delegate = delegate
    }
    
    func loadData(id: Int, type: TMDBType){
        self.mediaId = id
        self.mediaType = type
        Task {
            details = try await tmdbService.getShowDetails(for: id, type: type)
            delegate?.detailsDidLoad()
        }
        
        Task {
            await getMediaStates()
        }
        
    }
    
    private func getMediaStates() async {
        do {
            guard
                PersistenceManager.getSessionId() != nil,
                let mediaId = mediaId,
                let mediaType = mediaType
            else {
                return
            }
            let states = try await tmdbService.getMediaStatus(mediaId: mediaId, type: mediaType)
            isFavorite = states.favorite
            isWatchList = states.watchlist
           
            delegate?.didLoadStates(isFavorite: isFavorite)
            delegate?.didLoadStates(isWatchList: isWatchList)
            
            switch states.rated {
            case .bool(_):
                delegate?.didLoadStates(rate: nil)
            case .ratedClass(let rate):
                self.rate = Float(rate.value)
                delegate?.didLoadStates(rate: rate.value)
            }
        } catch {
            
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
                delegate?.didLoadStates(isFavorite: isFavorite)
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
                delegate?.didLoadStates(isWatchList: isWatchList)
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
    
    
    func rateMovie(rate: Float) {
        guard
            let details = self.details,
            PersistenceManager.getSessionId() != nil
        else {
            return
        }
        
        Task {
            do {
                delegate?.didLoadStates(rate: rate)
                isWatchList = false
                self.rate = rate
                delegate?.didLoadStates(isWatchList: isWatchList)
                try await tmdbService.updateRate(
                    mediaId: details.id,
                    mediaType: details.getType(),
                    rate: rate
                )
            } catch {
                print(error)
            }
   
        }
        
    }
    
    
    func deleteRate() {
        guard
            let details = self.details,
            PersistenceManager.getSessionId() != nil
        else {
            return
        }
        
        Task {
            do {
                delegate?.didLoadStates(rate: nil)
                rate = nil
                try await tmdbService.deleteRate(
                    mediaId: details.id,
                    mediaType: details.getType()
                )
            } catch {
                print(error)
            }
   
        }
        
    }
}

protocol DetailsViewModelDelegate: AnyObject {
    func detailsDidLoad()
    func didLoadStates(isFavorite: Bool)
    func didLoadStates(isWatchList: Bool)
    func didLoadStates(rate: Float?)
}
