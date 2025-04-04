//
//  PersistenceManager.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 26/03/25.
//

import Foundation


enum PersistenceActionType {
    
    case add, remove
    
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    enum Keys: String, CaseIterable {
        case favorites = "favorites"
        case sessionId = "sessionId"
        case requestToken = "requestToken"
        case accountId = "accountId"
    }
    
    
    static func updateWith(favorite: Favorite, actionType: PersistenceActionType) async throws {
        do {
            var favorites = try await retrieveFavorites()
            
            switch actionType {
            case .add:
                favorites.append(favorite)
                try save(favorites: favorites)
            case .remove:
                favorites.removeAll { $0.id == favorite.id }
                try save(favorites: favorites)
            }
            
        } catch {
            throw MWLError.invalidURL
        }
    }
    
    
    static func retrieveFavorites() async throws -> [Favorite] {
        
        guard let data = defaults.object(forKey: Keys.favorites.rawValue) as? Data else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let followers = try decoder.decode([Favorite].self, from: data)
            return followers
        } catch {
            throw MWLError.invalidURL
       
        }
        
    }
    
    
    static func save(favorites: [Favorite]) throws  {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites.rawValue)
        } catch {
            throw MWLError.invalidURL
        }
        
    }
    
    
    static func checkFavorite(id: Int) async -> Bool {
        
        do {
            let favorites = try await retrieveFavorites()
            let index = favorites.firstIndex { $0.id == id }
            return index != nil
        } catch {
            return false
        }
        
    }
    
    
    static func toogleFavorite(favorite: Favorite) async throws -> Bool {
        
        do {
            var favorites = try await retrieveFavorites()
            
            let index = favorites.firstIndex { $0.id == favorite.id }
            
            if index != nil {
                favorites.removeAll { $0.id == favorite.id }
            } else {
                favorites.append(favorite)
            }
            
            try save(favorites: favorites)
            return index == nil // if index is nil it means the favorite was added
        } catch {
            throw MWLError.invalidURL
        }
        
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
}
