//
//  FavoritesViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation
import UIKit

class MWLUsersMediaViewModel {
    private var items: [Media] = []
    private var filteredItems: [Media] = []
    private var isSearching = false
    private let service: MWLUsersMediaServiceProtocol
    let type: UserMediaType
    private var user: User?
    private var sessionId: String?

    weak var delegate: MWLUsersMediaViewModelDelegate?
    
    init(service: MWLUsersMediaServiceProtocol, type: UserMediaType, delegate: MWLUsersMediaViewModelDelegate? = nil) {
        self.service = service
        self.type = type
        self.delegate = delegate
        user = PersistenceManager.getUser()
        sessionId = PersistenceManager.getSessionId()
    }
    
    var activeItems: [Media] {
        isSearching ? filteredItems : items
    }
    
    
    func loadData(){
        guard checkSession() else {
            return
        }
        
        Task {
            guard let user else {
                return
            }
            let items = try await service.getItems(accountId: user.id, type: type)
            self.items = items
            self.delegate?.didUpdateItems()
        }
    }
    
    func checkSession() -> Bool {
        guard
            sessionId != nil,
            user != nil
        else {
            return false
        }
        
        return true
    }
    

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
