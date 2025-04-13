//
//  ImageService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 02/03/25.
//

import UIKit

class ImageService {
    
    static let shared = ImageService()
    
    private let tmdbBaseURL = "https://image.tmdb.org/t/p/w500/"
    
    private let youtubeThumbBaseURL = "https://img.youtube.com/vi/"
    
    private let gravatarBaseURL = "https://gravatar.com/avatar/"
  
    
    let cache = NSCache<NSString, UIImage>()
    
    func downloadTMDBImage(path: String) async -> UIImage? {
        let urlString = getTMDBURL(path: path)
        
        guard let url = URL(string: urlString) else { return nil }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }

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
    
    func downloadThumbnail(for video: Video) async -> UIImage? {
        guard 
            let urlString = getThumbUrl(from: video),
            let url = URL(string: urlString)
        else {
            return nil
        }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }

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
    
    
    func downloadGravatar(hash: String) async -> UIImage? {
        let urlString = "\(gravatarBaseURL)\(hash)"
        guard
            let url = URL(string: urlString)
        else {
            return nil
        }
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }

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
    
    func getTMDBURL(path: String) -> String {
        return "\(tmdbBaseURL)\(path)"
    }
    
    private func getThumbUrl(from video: Video) -> String? {
        switch video.site {
            case "YouTube":
                return getYoutubeThumbUrl(videoId: video.key)
            case "Vimeo":
                return getVimeoThumbUrl(videoId: video.key)
            default:
                return nil
        }
    }
    
    
    private func getYoutubeThumbUrl(videoId: String) -> String {
        return "\(youtubeThumbBaseURL)\(videoId)/0.jpg"
    }
    
    private func getVimeoThumbUrl(videoId: String) -> String {
        return "https://vumbnail.com/\(videoId).jpg"
    }
    
}
