//
//  ScreenAssembly.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class ScreenAssembly {
    
    // MARK: Singleton
    
    static let shared = ScreenAssembly()
    
    // MARK: Properties
    
    private let favoritesService: FavoritesService
    private let placeService: PlaceService
    private var userLocationService: UserLocationService
    private let lastLocationService: LastLocationService
    private let validationService: ValidationService
    private let authService: AuthService
    
    // MARK: Life Cycle
    
    private init() {
        self.favoritesService = FavoritesServiceImpl()
        self.placeService = PlaceServiceImpl()
        self.userLocationService = UserLocationServiceImpl()
        self.lastLocationService = LastLocationServiceImpl()
        self.validationService = ValidationServiceImpl()
        self.authService = AuthServiceImpl()
    }
    
    // MARK: ScreenAssembly
    
    func makeFavoritesScreen() -> UIViewController {
        let viewModel = FavoritesViewModel(favoritesService: favoritesService)
        let vc = FavoritesViewController(viewModel: viewModel)
        return vc
    }
    
    func makeMapScreen() -> UIViewController {
        let viewModel = MapViewModel(
            placeService: placeService,
            userLocationService: userLocationService,
            lastLocationService: lastLocationService
        )
        let vc = MapViewController(viewModel: viewModel)
        userLocationService.delegate = viewModel
        return vc
    }
    
    func makeAuthScreen() -> UIViewController {
        let viewModel = AuthViewModel(validationService: validationService, authService: authService)
        let vc = AuthViewController(viewModel: viewModel)
        return vc
    }
    
    func makePlaceDetailsScreen(with place: Place) -> UIViewController {
        let favoritesService = FavoritesServiceImpl()
        let viewModel = PlaceDetailsViewModel(place: place, favoritesService: favoritesService)
        let vc = PlaceDetailsViewController(viewModel: viewModel)
        return vc
    }
}
