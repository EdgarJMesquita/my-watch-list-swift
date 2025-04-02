//
//  BannerViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 01/04/25.
//

import Foundation

class BannerViewModel {
    weak var delegate: BannerViewModelDelegate?
    public private(set) var isWatchList = false
    private let service: BannerService
    private(set) var mediaStates: MediaStates?
    public private(set) var details: Media?
    
    init(delegate: BannerViewModelDelegate? = nil) {
        self.service = BannerService()
        self.delegate = delegate
    }
    
    func loadData(type: TMDBType, category: TMDBCategory) async {
        Task {
            do {
            
                let shows = try await service.getTrendingMovies()
                let index = Int.random(in: 0..<shows.count)
                details = shows[index]
                delegate?.didLoadDetails()
                let states = try await service.getMediaStatus(mediaId: details!.id, type: type)
                isWatchList = states.watchlist
                delegate?.isWatchListDidLoad(isWatchList: isWatchList)
            } catch {
                print(error)
                guard error is MWLError else {
                    return
                }
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
                try await service.updateMediaWatchList(
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


protocol BannerViewModelDelegate: AnyObject {
    func isWatchListDidLoad(isWatchList: Bool)
    func didLoadDetails()
}

