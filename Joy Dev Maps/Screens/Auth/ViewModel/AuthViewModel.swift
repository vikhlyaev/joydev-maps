//
//  AuthViewModel.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 22.09.2023.
//

import UIKit

protocol AuthOutput {
    var errorText: Dynamic<String> { get }
    func numberOfRows() -> Int
    func parameterForRowAt(indexPath: IndexPath) -> AuthParameters
    func loginButtonTapped(login: String, password: String)
}

final class AuthViewModel: AuthOutput {
    
    // MARK: Properties
    
    private let login = Bundle.main.object(forInfoDictionaryKey: "Login") as? String
    private let password = Bundle.main.object(forInfoDictionaryKey: "Password") as? String
    private let screenAssembly: ScreenAssembly
    var errorText = Dynamic("")
    
    // MARK: Life Cycle
    
    init(screenAssembly: ScreenAssembly) {
        self.screenAssembly = screenAssembly
    }
    
    // MARK: Functions
    
    func numberOfRows() -> Int {
        AuthParameters.allCases.count
    }
    
    func parameterForRowAt(indexPath: IndexPath) -> AuthParameters {
        AuthParameters.allCases[indexPath.row]
    }
    
    func loginButtonTapped(login: String, password: String) {
        guard let correctLogin = self.login, let correctPassword = self.password else {
            errorText.value = AuthConstants.errorLoginAndPasswordNotFound
            return
        }
        if login == correctLogin && password == correctPassword {
            let mapViewController = screenAssembly.makeMapScreen()
            let window = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.last { $0.isKeyWindow }
            window?.rootViewController = mapViewController
        } else {
            errorText.value = AuthConstants.errorLoginAndPasswordIncorrect
        }
    }
}
