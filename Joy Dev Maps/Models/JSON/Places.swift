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

struct Place: Decodable {
    let id: String
    let categories: [Category]
    let distance: Int
    let geocodes: Geocode
    let link: URL
    let location: Location
    let name: String

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

struct Category: Decodable {
    let name: String
    let icon: Icon
}

struct Icon: Decodable {
    let iconPrefix: String
    let suffix: String

    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

struct Geocode: Decodable {
    let main: LocationCoordinate
}

struct LocationCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Location: Decodable {
    let address: String?
    let country: String
    let locality: String
    let postcode: String?
    let region: String
}
