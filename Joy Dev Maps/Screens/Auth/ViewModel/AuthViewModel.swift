//
//  AuthViewModel.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 22.09.2023.
//

import UIKit

protocol AuthOutput {
    var errorText: Dynamic<String> { get }
    var isValidRegForm: Dynamic<Bool> { get }
    var isSuccessCheckLoginForm: Dynamic<Bool> { get }
    func numberOfRows(with state: AuthState) -> Int
    func parameterForRowAt(indexPath: IndexPath, with state: AuthState) -> Parameters
    func validateRegForm(login: String, email: String, password: String, repeatedPassword: String)
    func check(login: String, password: String)
    func saveUser(_ user: User)
    func login(with login: String, and password: String)
}

final class AuthViewModel: AuthOutput {
    
    // MARK: Properties
    
    private let validationService: ValidationService
    private let authService: AuthService
    private let screenAssembly = ScreenAssembly.shared
    private var currentUser: User? {
        didSet {
            guard let currentUser else { return }
            authService.add(user: currentUser)
        }
    }
    
    var errorText = Dynamic("")
    var isValidRegForm = Dynamic(false)
    var isSuccessCheckLoginForm = Dynamic(false)
    
    // MARK: Life Cycle
    
    init(validationService: ValidationService, authService: AuthService) {
        self.validationService = validationService
        self.authService = authService
        currentUser = authService.loadUser()
    }

    // MARK: Private functions
    
    private func openMapScreen() {
        let tabBarController = TabBarController()
        let window = UIApplication.shared.connectedScenes.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }.last { $0.isKeyWindow }
        window?.rootViewController = tabBarController
    }
    
    // MARK: AuthOutput
    
    func numberOfRows(with state: AuthState) -> Int {
        switch state {
        case .registration:
            return RegParameters.allCases.count
        case .login:
            return AuthParameters.allCases.count
        }
    }
    
    func parameterForRowAt(indexPath: IndexPath, with state: AuthState) -> Parameters {
        switch state {
        case .registration:
            return RegParameters.allCases[indexPath.row]
        case .login:
            return AuthParameters.allCases[indexPath.row]
        }
    }
    
    func validateRegForm(login: String, email: String, password: String, repeatedPassword: String) {
        let isValidLogin = validationService.isValidLogin(login)
        let isValidEmail = validationService.isValidEmail(email)
        let isValidPassword = validationService.isValidPassword(password)
        let isValidRepeatedPassword = password == repeatedPassword
        if !isValidLogin { errorText.value = AuthConstants.Error.nameIncorrect }
        if !isValidEmail { errorText.value = AuthConstants.Error.emailIncorrect }
        if !isValidPassword { errorText.value = AuthConstants.Error.passwordIncorrect }
        if !isValidRepeatedPassword { errorText.value = AuthConstants.Error.repeatPasswordIncorrect }
        isValidRegForm.value = isValidLogin && isValidEmail && isValidPassword && isValidRepeatedPassword
    }
    
    func check(login: String, password: String) {
        guard let currentUser else { return }
        if login == currentUser.login && password == currentUser.password {
            isSuccessCheckLoginForm.value = true
        } else {
            isSuccessCheckLoginForm.value = false
            errorText.value = AuthConstants.Error.loginOrPasswordIncorrect
        }
    }
    
    func saveUser(_ user: User) {
        currentUser = user
    }
    
    func login(with login: String, and password: String) {
        openMapScreen()
    }
}
