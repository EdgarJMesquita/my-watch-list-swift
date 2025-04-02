//
//  FavoritesViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation
import UIKit

class MWLUsersMediaViewModel {
    private(set) var isLogged = false
    private var items: [Media] = []
    private var filteredItems: [Media] = []
    private var isSearching = false
    private let service: MWLUsersMediaServiceProtocol
    let type: UserMediaType

    weak var delegate: MWLUsersMediaViewModelDelegate?
    
    init(service: MWLUsersMediaServiceProtocol, type: UserMediaType, delegate: MWLUsersMediaViewModelDelegate? = nil) {
        self.service = service
        self.type = type
        self.delegate = delegate
    }
    
    var activeItems: [Media] {
        isSearching ? filteredItems : items
    }
    
    
    func loadData(){
        isLogged = checkSession()
        
        if isLogged == false {
            delegate?.didGetUnauthorized()
            return
        }
        
        Task {
            guard let accountId = PersistenceManager.getInt(key: .accountId) else {
                return
            }
            let items = try await service.getItems(accountId: accountId, type: type)
            self.items = items
            self.delegate?.didUpdateItems()
        }
    }
    
    func checkSession() -> Bool {
        guard
            PersistenceManager.getInt(key: .accountId) != nil,
            PersistenceManager.getString(key: .sessionId) != nil
        else {
            return false
        }
        
        return true
    }
    
    
//    func removeFavorite(favorite: Favorite) async throws {
//       try await PersistenceManager.updateWith(favorite: favorite, actionType: .remove)
//    }
    

    func onSearch(for searchController: UISearchController){
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredItems.removeAll()
            delegate?.didUpdateItems()
            isSearching = false
            return
        }
        isSearching = true
        
        filteredItems = items.filter { $0.getTitle().lowercased().contains(filter.lowercased()) }
        delegate?.didUpdateItems()
    }
  
}


protocol MWLUsersMediaViewModelDelegate: AnyObject {
    func didUpdateItems()
    func didGetUnauthorized()
}

protocol MWLUsersMediaServiceProtocol: AnyObject {
    func getItems(accountId: Int, type: UserMediaType) async throws -> [Media]
}
