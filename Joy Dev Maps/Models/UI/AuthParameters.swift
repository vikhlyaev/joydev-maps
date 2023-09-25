//
//  AuthParameters.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 22.09.2023.
//

import Foundation

enum AuthParameters: CaseIterable {
    case name
    case password
    
    var placeholder: String {
        switch self {
        case .name:
            "Имя пользователя"
        case .password:
            "Пароль"
        }
    }
}
