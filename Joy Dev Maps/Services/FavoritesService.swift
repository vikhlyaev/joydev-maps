//
//  FavoritesService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import Foundation

protocol FavoritesService {
    func count() -> Int
    func object(at index: Int) -> Place?
    func loadFavorites() -> [Place]?
    func saveFavorites(places: [Place])
    func addPlace(_ place: Place)
    func removePlace(_ place: Place)
    func removePlace(for index: Int)
    func checkIsFavorites(place: Place) -> Place
    func clean()
}

// MARK: - Implementation

final class FavoritesServiceImpl: FavoritesService {
    
    // MARK: Properties
    
    private let key = "favorites_places"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var favoritesPlaces: [Place] = [] {
        didSet {
            print("didSet = ", favoritesPlaces.count)
            saveFavorites(places: favoritesPlaces)
        }
    }
    
    // MARK: Life Cycle
    
    init() {
        favoritesPlaces = loadFavorites() ?? []
    }
    
    deinit {
        print("FavoritesServiceImpl deinit")
    }
    
    // MARK: FavoritesService
    
    func count() -> Int {
        print("favoritesPlaces.count = ", favoritesPlaces.count)
        return(favoritesPlaces.count)
    }
    
    func object(at index: Int) -> Place? {
        if index < favoritesPlaces.count {
            return favoritesPlaces[index]
        }
        return nil
    }
    
    func loadFavorites() -> [Place]? {
        guard
            let data = UserDefaults.standard.object(forKey: key) as? Data,
            let places = try? decoder.decode([Place].self, from: data)
        else { return nil }
        return places
    }
    
    func saveFavorites(places: [Place]) {
        UserDefaults.standard.removeObject(forKey: key)
        guard let data = try? encoder.encode(places) else { return }
        UserDefaults.standard.set(data, forKey: key)
        
        print("saveFavorites(places: [Place]) = ", places.count)
    }
    
    func addPlace(_ place: Place) {
        favoritesPlaces.append(place)
    }
    
    func removePlace(_ place: Place) {
        guard let index = favoritesPlaces.firstIndex(where: { $0.id == place.id }) else { return }
        favoritesPlaces.remove(at: index)
    }
    
    func removePlace(for index: Int) {
        favoritesPlaces.remove(at: index)
    }
    
    func checkIsFavorites(place: Place) -> Place {
        if favoritesPlaces.contains(where: { $0.id == place.id }) {
            var updatedPlace = place
            updatedPlace.isFavorites.toggle()
            return updatedPlace
        } else {
            return place
        }
    }
    
    func clean() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


