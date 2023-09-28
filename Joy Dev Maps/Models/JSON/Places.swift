//
//  Places.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 24.09.2023.
//

import Foundation

struct Places: Decodable {
    let results: [Place]
}

struct Place: Codable {
    let id: String
    let categories: [Category]
    let distance: Int
    let geocodes: Geocode
    let link: URL
    let location: Location
    let name: String
    var isFavorites = false

    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case categories
        case distance
        case geocodes
        case link
        case location
        case name
    }
}

struct Category: Codable {
    let name: String
}

struct Geocode: Codable {
    let main: LocationCoordinate
}

struct LocationCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Location: Codable {
    let address: String?
    let country: String?
    let locality: String?
    let postcode: String?
    let region: String?
}

struct Photo: Decodable {
    let photoPrefix: String
    let photoSuffix: String

    enum CodingKeys: String, CodingKey {
        case photoPrefix = "prefix"
        case photoSuffix = "suffix"
    }
}
