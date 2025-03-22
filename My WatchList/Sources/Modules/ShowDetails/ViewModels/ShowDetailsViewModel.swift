//
//  DetailsViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/03/25.
//

import UIKit

class ShowDetailsViewModel {
    weak var delegate: DetailsViewModelDelegate?
    
    public private(set) var details: ShowDetails?
    
    private let tmdbService: TMDBService

    init(delegate: DetailsViewModelDelegate? = nil) {
        self.tmdbService = TMDBService()
        self.delegate = delegate
    }
    
    func loadData(for show: Show){
        Task {
            details = try await tmdbService.getShowDetails(for: show.id, type: show.getType())
            delegate?.detailsDidLoad()
        }
    }
}

protocol DetailsViewModelDelegate: AnyObject {
    func detailsDidLoad()
}
