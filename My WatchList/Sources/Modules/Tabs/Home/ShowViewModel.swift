//
//  ShowViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 14/03/25.
//

import UIKit

class ShowViewModel {
    weak var delegate: ShowViewModelDelegate?

    public private(set) var shows: [Show] = []
    private let tmdbService: TMDBService

    init() {
        self.tmdbService = TMDBService()
    }
    
    func loadData(type: TMDBType, category: TMDBCategory) async {
        Task {
            do {
                shows = try await tmdbService.getData(type: type, category: category)
                delegate?.showsDidUpdate()
            } catch {
                print(error)
                guard error is MWLError else {
                    return
                }
            }

        }
    }

    func downloadImage(path: String) async -> UIImage? {
        return await tmdbService.downloadImage(path: path)
    }
}

protocol ShowViewModelDelegate: AnyObject {
    func showsDidUpdate()
}
