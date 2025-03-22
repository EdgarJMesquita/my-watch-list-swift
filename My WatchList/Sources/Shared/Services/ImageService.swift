//
//  ImageService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/03/25.
//

import UIKit

class ImageService {
    
    static let shared = ImageService()
    
    private let baseURL = "http://www.omdbapi.com"
    private let apiKey: String
    
    let cache = NSCache<NSString, UIImage>()
    
    init(){
        apiKey = EnvManager.get(key: .omdbAPIKey) ?? ""
    }
    
    func download(imdbId: String) async -> UIImage? {
        let stringUrl = "\(baseURL)&apikey=\(apiKey)&i=\(imdbId)"
        
        let cacheKey = NSString(string: stringUrl)

        if let image = cache.object(forKey: cacheKey) {
            return image
        }

        guard let url = URL(string: stringUrl) else { return nil }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                return nil
            }
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            print(error)
            return nil
        }
    }
}
