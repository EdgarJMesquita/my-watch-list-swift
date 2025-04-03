//
//  AuthService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation
import UIKit
import AuthenticationServices

fileprivate let baseURL = Constants.TMDBBaseURL.rawValue

class AuthService: RequestService {
    func getRequestToken() async throws -> String {
        let path = "/authentication/token/new"
        return try await request(with: path, model: RequestTokenResponse.self, cache: false).requestToken
    }
    
    func authenticate(delegate: ASWebAuthenticationPresentationContextProviding) async throws {
        
        let requestToken = try await getRequestToken()
        
        let authUrlString = "https://www.themoviedb.org/authenticate/\(requestToken)?redirect_to=com.edgar.My-WatchList://main"
        
        guard let url = URL(string: authUrlString) else {
            throw MWLError.invalidURL
        }
        
//        let session = ASWebAuthenticationSession(url: url, callbackURLScheme: "com.edgar.My-WatchList"){ callbackURL, error in
//            print(url)
//            print(callbackURL)
//           
//            
//            guard
//                callbackURL?.getQueryparams(),
//                params["approved"] == "true",
//                let requestToken = params["request_token"]
//            else {
//                throw MWLError.invalidURL
//            }
//            
//            Task {
//                do {
//                    try await AuthService.fetchSessionId(requestToken: requestToken)
//                    let accountDetails = try await AuthService().getAccountDetails()
//                    let username = accountDetails.name.isEmpty ? accountDetails.username : accountDetails.name
//                    
//                    flowController?.presentLoginSuccess(username: username ?? "My friend")
//                    
//                } catch {
//                    flowController?.presentLoginFailure()
//                    print(error.localizedDescription)
//                }
//            }
//    
//        }
//        session.presentationContextProvider = delegate
//        session.start()
        
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
