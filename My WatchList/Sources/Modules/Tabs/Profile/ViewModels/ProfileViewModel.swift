//
//  ProfileViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation
import AuthenticationServices

class ProfileViewModel {
    
    let service: AuthService
    private(set) var user: User? = nil
    weak var delegate: ProfileViewModelDelegate?
    
    
    init() {
        self.service = AuthService()
    }
    
    
    func loadData(){
        guard PersistenceManager.getSessionId() != nil else {
            return
        }
        getAccountDetails()
    }
    
    
    private func getAccountDetails(){
        Task {
            let user = try await service.getAccountDetails()
            PersistenceManager.set(key: .accountId, value: user.id)
            delegate?.didLoadAccountDetails(user: user)
            self.user = user
        }
    }
    
    func logout(){
        PersistenceManager.clear()
    }
}


protocol ProfileViewModelDelegate: AnyObject {
    func didLoadAccountDetails(user: User)
}
