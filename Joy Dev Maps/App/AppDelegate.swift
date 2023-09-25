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
        let serviceAssembly: ServiceAssembly = ServiceAssemblyImpl()
        let screenAssembly: ScreenAssembly = ScreenAssemblyImpl(serviceAssembly: serviceAssembly)
        window?.rootViewController = screenAssembly.makeMapScreen()
        window?.makeKeyAndVisible()
        return true
    }
}

