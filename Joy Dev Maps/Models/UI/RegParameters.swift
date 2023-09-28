//
//  RegParameters.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 27.09.2023.
//

import Foundation

enum RegParameters: CaseIterable, Parameters {
    case login
    case email
    case password
    case repeatedPassword
    
    
    var placeholder: String {
        switch self {
        case .login:
            "Имя пользователя"
        case .email:
            "Email"
        case .password:
            "Пароль"
        case .repeatedPassword:
            "Повторите пароль"
        }
    }
}
