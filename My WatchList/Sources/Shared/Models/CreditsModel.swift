//
//  CreditsModel.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 16/03/25.
//

import Foundation

// MARK: - Credits
struct Credits: Codable {
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, job
    }
    
    func getGender() -> String {
        switch self.gender {
            case 1:
                return "Female"
            case 2:
                return "Male"
            default:
                return "Not specified"
        }
    }
}
