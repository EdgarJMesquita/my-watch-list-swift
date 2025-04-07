//
//  UserRatedListViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 07/04/25.
//

import Foundation

class UserRatedListViewModel {
    
    
    private let service: RatedService
    private var user: User?
    private(set) var items: [Media] = []
    weak var delegate: UserRatedListViewModelDelegate?
    
    
    init() {
        self.service = RatedService()
        self.user = PersistenceManager.getUser()
    }
    
    
    func loadData(type: UserMediaType){
        guard let accountId = user?.id else {
            return
        }
        
        Task {
          
            let items = try await service.getItems(accountId: accountId, type: type)
            self.items = items
            self.delegate?.didUpdateItems()
        }
    }
    
    
}


protocol UserRatedListViewModelDelegate: AnyObject {
    func didUpdateItems()
}
