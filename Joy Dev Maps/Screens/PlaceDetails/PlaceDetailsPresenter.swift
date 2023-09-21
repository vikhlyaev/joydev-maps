//
//  PlaceDetailsPresenter.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

final class PlaceDetailsPresenter {

    weak var view: PlaceDetailsInput?
    
}

// MARK: - PlaceDetailsOutput

extension PlaceDetailsPresenter: PlaceDetailsOutput {
    func viewIsReady() {
        print(#function)
    }
}
