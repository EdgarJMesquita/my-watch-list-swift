//
//  ShowViewModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 14/03/25.
//

import UIKit

class ShowViewModel {
    weak var delegate: ShowViewModelDelegate?

    public private(set) var shows: [Media] = []
    private let service: ShowService

    init() {
        self.service = ShowService()
    }
    
    func loadData(type: TMDBType, category: TMDBCategory) async {
        Task {
            do {
                shows = try await service.getShows(type: type, category: category)
                delegate?.showsDidUpdate()
            } catch {
                print(error)
                guard error is MWLError else {
                    return
                }
            }

        }
    }
    
    

}

protocol ShowViewModelDelegate: AnyObject {
    func showsDidUpdate()
}
