//
//  ScreenAssembly.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

protocol ScreenAssembly {
    func makePlaceDetailsScreen() -> UIViewController
    func makeMapScreen() -> UIViewController
    func makeAuthScreen() -> UIViewController
}

// MARK: - Implementation

final class ScreenAssemblyImpl: ScreenAssembly {
    
    // MARK: Properties
    
    private let serviceAssembly: ServiceAssembly
    
    // MARK: Life Cycle
    
    init(serviceAssembly: ServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    // MARK: ScreenAssembly
    
    func makeMapScreen() -> UIViewController {
        let placeService = serviceAssembly.makePlaceService()
        var userLocationService = serviceAssembly.makeUserLocationService()
        let lastLocationService = serviceAssembly.makeLastLocationService()
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
        let viewModel = AuthViewModel(screenAssembly: self)
        let vc = AuthViewController(viewModel: viewModel)
        return vc
    }
    
    func makePlaceDetailsScreen() -> UIViewController {
        let viewModel = PlaceDetailsViewModel()
        let vc = PlaceDetailsViewController(viewModel: viewModel)
        return vc
    }
}
