//
//  PersonService.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 05/04/25.
//

import Foundation

class PersonService: RequestService {
    func getPersonDetails(for personId: Int) async throws -> Person {
        let path = "/person/\(personId)"
        let queryItems = [URLQueryItem(name: "append_to_response", value: "images,combined_credits")]
        return try await request(with: path, model: Person.self, queryItems: queryItems)
    }
    
}
