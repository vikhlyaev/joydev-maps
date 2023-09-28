//
//  TabBarController.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: Tabs
    
    private enum Tabs {
        case map
        case favorites
        
        var title: String {
            switch self {
            case .map:
                "Карта"
            case .favorites:
                "Избранное"
            }
        }
        
        var imageName: String {
            switch self {
            case .map:
                return "map"
            case .favorites:
                return "bookmark"
            }
        }
    }
    
    // MARK: Properties
    
    private let screenAssembly: ScreenAssembly = ScreenAssembly.shared
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTabItems()
    }
    
    // MARK: Setup UI
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.stackedLayoutAppearance.selected.iconColor = .systemBlue
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemBlue
        ]
        tabBar.standardAppearance = appearance
    }
    
    private func setupTabItems() {
        let tabs: [Tabs] = [.map, .favorites]
        
        viewControllers = tabs.map {
            switch $0 {
            case .map:
                let viewController = screenAssembly.makeMapScreen()
                return wrapInNavigationController(viewController)
            case .favorites:
                let viewController = screenAssembly.makeFavoritesScreen()
                viewController.title = $0.title
                return wrapInNavigationController(viewController)
            }
        }
        
        viewControllers?.enumerated().forEach {
            $1.title = tabs[$0].title
            $1.tabBarItem.title = tabs[$0].title
            $1.tabBarItem.image = UIImage(systemName: tabs[$0].imageName)
            $1.tabBarItem.tag = $0
        }
    }
    
    // MARK: Private functions
    
    private func wrapInNavigationController(_ vc: UIViewController) -> UINavigationController {
        UINavigationController(rootViewController: vc)
    }
}

