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
