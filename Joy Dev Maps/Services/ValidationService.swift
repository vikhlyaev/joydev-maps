//
//  ValidationService.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 27.09.2023.
//

import Foundation

protocol ValidationService {
    func isValidLogin(_ login: String) -> Bool
    func isValidEmail(_ email: String) -> Bool
    func isValidPassword(_ password: String) -> Bool
}

// MARK: - Implementation

final class ValidationServiceImpl: ValidationService {
    func isValidLogin(_ login: String) -> Bool {
        let nameRegEx = "[A-Za-z]{2,}"
        let namePred = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: login)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" 
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^.{6,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
