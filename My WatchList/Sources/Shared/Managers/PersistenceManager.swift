//
//  PersistenceManager.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation
import UIKit

enum PersistenceActionType {
    
    case add, remove
    
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    enum Keys: String, CaseIterable {
        case sessionId = "sessionId"
        case requestToken = "requestToken"
        case accountId = "accountId"
        case user = "user"
        case avatar = "avatar"
    }
    
    
    
    static func saveSessionId(_ sessionId: String){
    
        defaults.set(sessionId, forKey: Keys.sessionId.rawValue)
        
    }
    
    
    static func getSessionId() -> String? {
        
        guard let sessionId = defaults.object(forKey: Keys.sessionId.rawValue) as? String else {
           return nil
        }
        
        return sessionId
        
    }
    
    
    static func removeSessionId(){
        defaults.removeObject(forKey: Keys.sessionId.rawValue)
    }
    
    
    static func saveRequestToken(_ requestToken: String){
    
        defaults.set(requestToken, forKey: Keys.requestToken.rawValue)
        
    }
    
    
    static func getRequestToken() -> String? {
        
        guard let requestToken = defaults.object(forKey: Keys.requestToken.rawValue) as? String else {
           return nil
        }
        
        return requestToken
        
    }
    
    
    static func set(key: Keys, value: Any){
        defaults.set(value, forKey: key.rawValue)
    }
    
    
    static func getString(key: Keys) -> String? {
        
        guard let string = defaults.object(forKey: key.rawValue) as? String else {
           return nil
        }
        
        return string
        
    }
    
    
    static func getInt(key: Keys) -> Int? {
        
        guard let integer = defaults.object(forKey: key.rawValue) as? Int else {
           return nil
        }
        
        return integer
        
    }
    
    
    static func clear(){
        for key in Keys.allCases {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
    
    
    static func saveUser(user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            return
        }
        defaults.setValue(data, forKey: Keys.user.rawValue)
    }
    
    
    static func getUser() -> User? {
        guard let data = defaults.object(forKey: Keys.user.rawValue) as? Data else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    
    static func saveAvatar(data: Data) {
        defaults.setValue(data, forKey: Keys.avatar.rawValue)
    }
    
    
    static func getAvatar() -> UIImage {
        guard let data = defaults.data(forKey: Keys.avatar.rawValue) else {
            return .mwlProfile
        }
        if let image = UIImage(data: data) {
            return image.withRenderingMode(.alwaysOriginal)
        } else {
            return .mwlProfile
        }
    }
    
    
}
