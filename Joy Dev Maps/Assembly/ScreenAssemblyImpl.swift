//
//  ScreenAssemblyImpl.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

final class ScreenAssemblyImpl: ScreenAssembly {
    func makeMapScreen() -> UIViewController {
        let presenter = MapPresenter()
        let vc = MapViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makeAuthScreen() -> UIViewController {
        let presenter = AuthPresenter()
        let vc = AuthViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
    
    func makePlaceDetailsScreen() -> UIViewController {
        let presenter = PlaceDetailsPresenter()
        let vc = PlaceDetailsViewController(presenter: presenter)
        presenter.view = vc
        return vc
    }
}
