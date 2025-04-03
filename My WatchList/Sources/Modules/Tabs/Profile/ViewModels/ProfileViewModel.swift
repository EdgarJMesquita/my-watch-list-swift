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
    private(set) var isLogged = false
    weak var delegate: ProfileViewModelDelegate?
    
    init() {
        self.service = AuthService()
    }
    
    func authenticate(delegate: ASWebAuthenticationPresentationContextProviding){
        Task {
            try await service.authenticate(delegate: delegate)
        }
    }
    
    func loadData(){
        checkSession()
    }
    
    private func checkSession(){
        isLogged = PersistenceManager.getSessionId() != nil
        
        if isLogged {
            getAccountDetails()
        }
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
