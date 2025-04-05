//
//  LoginViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 03/04/25.
//

import Foundation

class LoginViewModel {
    let service: AuthService
    weak var delegate: ProfileViewModelDelegate?
    
    init() {
        self.service = AuthService()
    }
    
    func authenticate() async throws -> (URL, String) {
      
        let requestToken = try await service.getRequestToken()
        let urlString = try service.getAuthURL(requestToken: requestToken)
        let callbackURLScheme = service.getCallbackURLScheme()
        
        return (urlString, callbackURLScheme)
    }
    
    func finishAuthentication(requestToken: String) async throws -> String{
        let sessionId = try await service.fetchSessionId(requestToken: requestToken)
        PersistenceManager.saveSessionId(sessionId)
        
        let account = try await service.getAccountDetails()
        PersistenceManager.set(key: .accountId, value: account.id)
        
        if account.name.isEmpty {
            return account.username
        } else {
            return account.name
        }
    }
    
}
