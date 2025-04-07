//
//  ProfileViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation
import AuthenticationServices

class ProfileViewModel {
    

    let ratedService: RatedService
    let authService: AuthService
    
    private(set) var user: User? = nil
    weak var delegate: ProfileViewModelDelegate?
    
    
    init() {
        self.authService = AuthService()
        self.ratedService = RatedService()
    }
    
    
    func loadData(){
        guard PersistenceManager.getSessionId() != nil else {
            return
        }
        getAccountDetails()
    }
    
    
    private func getAccountDetails(){
        Task {
            let user = try await authService.getAccountDetails()
            PersistenceManager.saveUser(user: user)
            delegate?.didLoadAccountDetails(user: user)
            self.user = user
  
            await AvatarUtils.downloadAndFormat(user: user)
            
        }
    }
    
    func logout(){
        PersistenceManager.clear()
    }
}


protocol ProfileViewModelDelegate: AnyObject {
    func didLoadAccountDetails(user: User)
}
