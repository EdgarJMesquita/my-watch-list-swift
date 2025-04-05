//
//  PersonDetailsViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 19/03/25.
//

import Foundation

class PersonDetailsViewModel {
    weak var delegate: PersonDetailsViewModelDelegate?
    public private(set) var isFavorite = false
    public private(set) var person: Person?
    
    private let tmdbService: PersonService

    init(delegate: PersonDetailsViewModelDelegate? = nil) {
        self.tmdbService = PersonService()
        self.delegate = delegate
    }
    
    func loadData(for personId: Int){
        Task {
            person = try await tmdbService.getPersonDetails(for: personId)
            delegate?.detailsDidLoad()
        }
    }
    
}

protocol PersonDetailsViewModelDelegate: AnyObject {
    func detailsDidLoad()
}
