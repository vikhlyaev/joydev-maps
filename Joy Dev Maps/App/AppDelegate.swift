//
//  AppDelegate.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let authService: AuthService = AuthServiceImpl()
        if authService.loadUser() != nil {
            window?.rootViewController = TabBarController()
        } else {
            window?.rootViewController = ScreenAssembly.shared.makeAuthScreen()
        }
        window?.makeKeyAndVisible()
        return true
    }
}

