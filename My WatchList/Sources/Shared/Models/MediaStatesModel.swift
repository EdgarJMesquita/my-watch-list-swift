//
//  MediaStates.swift
//  My WatchList
//
//  Created by Edgar Jonas Mesquita da Silva on 30/03/25.
//

import Foundation

// MARK: - MediaState
struct MediaStates: Codable {
    let id: Int
    let favorite: Bool
    let rated: RatedUnion
    let watchlist: Bool
}

enum RatedUnion: Codable {
    case bool(Bool)
    case ratedClass(RatedClass)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode(RatedClass.self) {
            self = .ratedClass(x)
            return
        }
        throw DecodingError.typeMismatch(RatedUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for RatedUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .ratedClass(let x):
            try container.encode(x)
        }
    }
}

// MARK: - RatedClass
struct RatedClass: Codable {
    let value: Float
}

