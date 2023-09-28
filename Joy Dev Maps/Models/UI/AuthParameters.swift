//
//  AuthParameters.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 22.09.2023.
//

import Foundation

enum AuthParameters: CaseIterable, Parameters {
    case login
    case password
    
    var placeholder: String {
        switch self {
        case .login:
            "Имя пользователя"
        case .password:
            "Пароль"
        }
    }
}
