//
//  MapPresenter.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

final class MapPresenter {
    
    weak var view: MapInput?
    
}

// MARK: - MapOutput

extension MapPresenter: MapOutput {
    func viewIsReady() {
        print(#function)
    }
}

