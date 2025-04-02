//
//  AuthService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation
import UIKit

fileprivate let baseURL = Constants.TMDBBaseURL.rawValue

class AuthService: RequestService {
    func getRequestToken() async throws -> String {
        let path = "/authentication/token/new"
        
        return try await request(with: path, model: RequestTokenResponse.self).requestToken
//        
//        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
//            throw MWLError.missingConfigFile
//        }
//
//        let urlString = "\(baseURL)/authentication/token/new"
//        
//        
//        guard var components = URLComponents(string: urlString) else {
//            throw MWLError.invalidURL
//        }
//        
//        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
//        
//        guard let url = components.url else {
//            throw MWLError.invalidURL
//        }
//
//        do {
//            let (data, response) = try await URLSession.shared.data(from: url)
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                throw MWLError.invalidResponse
//            }
//
//            let requestTokenResponse = try JSONDecoder().decode(RequestTokenResponse.self, from: data)
//            return requestTokenResponse.requestToken
//        } catch {
//            print(error)
//            throw MWLError.invalidResponse
//        }
    }
    
    func authenticate() async throws {
        
        let requestToken = try await getRequestToken()
        
        print("Request Token: \(requestToken)")
        
        let authUrlString = "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=com.edgar.My-WatchList://main"
        
        guard let url = URL(string: authUrlString) else {
            throw MWLError.invalidURL
        }
        
        DispatchQueue.main.async {
            UIApplication.shared.open(url)
        }
       
    }
    
    
    static func fetchSessionId(requestToken: String) async throws {
        
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }
        
        let urlString = "\(baseURL)/authentication/session/new"
        
        guard var components = URLComponents(string: urlString) else {
            throw MWLError.invalidURL
        }
        
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        
        let parameters = ["request_token": requestToken] as [String : Any?]
        
        let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
        
        guard let url = components.url else {
            throw MWLError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "content-type": "application/json",
        ]
        request.httpBody = postData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode == 200
        else {
            if let a = response as? HTTPURLResponse {
                print(a.statusCode)
            }
            throw MWLError.invalidResponse
        }
        
        let requestSessionResponse = try JSONDecoder().decode(RequestSessionResponse.self, from: data)
        
        PersistenceManager.saveSessionId(requestSessionResponse.sessionId)
        
    
        let account = try await RequestService.request(with: "\(baseURL)/account", model: User.self)
        PersistenceManager.set(key: .accountId, value: account.id)
    }
    
    func getAccountDetails() async throws -> User {
        let path = "/account"
        return try await request(with: path, model: User.self)
    }
}
