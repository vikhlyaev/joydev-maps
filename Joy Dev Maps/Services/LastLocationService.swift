//
//  LastLocationService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 24.09.2023.
//

import Foundation

protocol LastLocationService {
    func loadLastLocation() -> LocationCoordinate?
    func saveLastLocation(location: LocationCoordinate)
    func clean()
}

// MARK: - Implementation

final class LastLocationServiceImpl: LastLocationService {
    
    // MARK: Properties
    
    private let key = "last_location"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: LastLocationService
    
    func loadLastLocation() -> LocationCoordinate? {
        guard 
            let data = UserDefaults.standard.object(forKey: key) as? Data,
            let location = try? decoder.decode(LocationCoordinate.self, from: data)
        else { return nil }
        return location
    }
    
    func saveLastLocation(location: LocationCoordinate) {
        guard let data = try? encoder.encode(location) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func clean() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
