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
    private var medias: [Media] = []
    
    init(delegate: BannerViewModelDelegate? = nil) {
        self.service = BannerService()
        self.delegate = delegate
    }
    
    
    func loadData(type: TMDBType, category: TMDBCategory) async {
        Task {
            do {
                medias = try await service.getTrendingMovies()
                details = medias.randomElement()
                delegate?.didLoadDetails()
                
                if PersistenceManager.getSessionId() != nil {
                    let states = try await service.getMediaStatus(mediaId: details!.id, type: type)
                    isWatchList = states.watchlist
                    delegate?.isWatchListDidLoad(isWatchList: isWatchList)
                }
              
            } catch {
                print(error)
            }
        }
    }
    
    
    func updateFromListRandomly(){
        details = medias.randomElement()
        delegate?.didLoadDetails()
    }
    
    
    func toogleWatchList() {
        guard
            let details = self.details,
            let user = PersistenceManager.getUser()
        else {
            return
        }
        
        Task {
            do {
                isWatchList.toggle()
                delegate?.isWatchListDidLoad(isWatchList: isWatchList)
                try await service.updateMediaWatchList(
                    accountId: user.id,
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

