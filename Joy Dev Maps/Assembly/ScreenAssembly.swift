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
    func makeMapScreen() -> UIViewController {
        let viewModel = MapViewModel()
        let vc = MapViewController(viewModel: viewModel)
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
