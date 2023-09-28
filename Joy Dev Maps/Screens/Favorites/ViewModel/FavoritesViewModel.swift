//
//  FavoritesViewModel.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import Foundation

protocol FavoritesOutput {
    var isLogout: Dynamic<Bool> { get }
    func numberOfRows() -> Int
    func titleForRowAt(indexPath: IndexPath) -> String
    func deletePlaceAt(indexPath: IndexPath)
    func selectPlaceAt(indexPath: IndexPath) -> Place?
    func logout()
}

final class FavoritesViewModel: FavoritesOutput {
    
    // MARK: Properties
    
    private let favoritesService: FavoritesService
    private let lastLocationService: LastLocationService
    private let authService: AuthService
    
    var isLogout = Dynamic(false)
    
    // MARK: Life Cycle
    
    init(favoritesService: FavoritesService, lastLocationService: LastLocationService, authService: AuthService) {
        self.favoritesService = favoritesService
        self.lastLocationService = lastLocationService
        self.authService = authService
    }
    
    // MARK: FavoritesService
    
    func numberOfRows() -> Int {
        favoritesService.count()
    }
    
    func titleForRowAt(indexPath: IndexPath) -> String {
        guard let currentPlace = favoritesService.object(at: indexPath.row) else { return "" }
        return currentPlace.name
    }
    
    func deletePlaceAt(indexPath: IndexPath) {
        favoritesService.removePlace(for: indexPath.row)
    }
    
    func selectPlaceAt(indexPath: IndexPath) -> Place? {
        favoritesService.object(at: indexPath.row)
    }
    
    func logout() {
        favoritesService.clean()
        lastLocationService.clean()
        authService.clean()
        isLogout.value = true
    }
}
