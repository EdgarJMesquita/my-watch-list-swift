//
//  RequestService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 28/03/25.
//

import Foundation

fileprivate let baseURL = Constants.TMDBBaseURL.rawValue

class RequestService {
    
    
    func request<T>(
        with path: String,
        model: T.Type,
        queryItems: [URLQueryItem]=[],
        cache: Bool = true
    ) async throws -> T where T : Decodable {
        
        
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }

        let urlString = "\(baseURL)\(path)"
        
        guard var components = URLComponents(string: urlString) else {
            throw MWLError.invalidURL
        }

        components.queryItems = queryItems
        
        components.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        
        if let sessionId = PersistenceManager.getSessionId() {
            components.queryItems?.append(URLQueryItem(name: "session_id", value: sessionId))
        }
        
        guard let url = components.url else {
            throw MWLError.invalidURL
        }
        
        
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 300.0)
        request.httpMethod = "GET"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let sessionConfig = URLSessionConfiguration.default
        
        sessionConfig.urlCache = cache ? URLCache.shared : nil
       
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw MWLError.invalidResponse
            }

            return try JSONDecoder().decode(model, from: data)

        } catch {
            print(error)
            throw MWLError.invalidResponse
        }

    }
    
    static func request<T>(
        with urlString: String,
        model: T.Type,
        queryItems: [URLQueryItem]=[],
        cache: Bool = true
    ) async throws -> T where T : Decodable {
        guard let apiKey = EnvManager.get(key: .tmdbAPIKey) else {
            throw MWLError.missingConfigFile
        }

        guard var components = URLComponents(string: urlString) else {
            throw MWLError.invalidURL
        }

        components.queryItems = queryItems
        
        components.queryItems?.append(URLQueryItem(name: "api_key", value: apiKey))
        
        if let sessionId = PersistenceManager.getSessionId() {
            components.queryItems?.append(URLQueryItem(name: "session_id", value: sessionId))
        }
        
        
        guard let url = components.url else {
            throw MWLError.invalidURL
        }
        
        
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 300.0)
        request.httpMethod = "GET"

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let sessionConfig = URLSessionConfiguration.default
        
        sessionConfig.urlCache = cache ? URLCache.shared : nil
        
        sessionConfig.requestCachePolicy = .returnCacheDataElseLoad
        
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let (data, response) = try await session.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw MWLError.invalidResponse
            }

            return try JSONDecoder().decode(model, from: data)

        } catch {
            print(error)
            throw MWLError.invalidResponse
        }

    }
    
    func create(with path: String, body: [String : Any?]) async throws {
        
        guard
            let apiKey = EnvManager.get(key: .tmdbAPIKey),
            let sessionId = PersistenceManager.getSessionId()
        else {
            throw MWLError.missingConfigFile
        }
        
        let urlString = "\(baseURL)\(path)"
        
        guard var components = URLComponents(string: urlString) else {
            throw MWLError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "session_id", value: sessionId)
        ]
   
        
        let postData = try JSONSerialization.data(withJSONObject: body, options: [])
        
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
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            String(response.statusCode).starts(with: "2")
        else {
            if let a = response as? HTTPURLResponse {
                print(a.statusCode)
            }
            throw MWLError.invalidResponse
        }
    }
    
    
    func delete(with path: String) async throws {
        
        guard
            let apiKey = EnvManager.get(key: .tmdbAPIKey),
            let sessionId = PersistenceManager.getSessionId()
        else {
            throw MWLError.missingConfigFile
        }
        
        let urlString = "\(baseURL)\(path)"
        
        guard var components = URLComponents(string: urlString) else {
            throw MWLError.invalidURL
        }
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "session_id", value: sessionId)
        ]
   
        
        guard let url = components.url else {
            throw MWLError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard
            let response = response as? HTTPURLResponse,
            String(response.statusCode).starts(with: "2")
        else {
            if let a = response as? HTTPURLResponse {
                print(a.statusCode)
            }
            throw MWLError.invalidResponse
        }
    }
    
}
