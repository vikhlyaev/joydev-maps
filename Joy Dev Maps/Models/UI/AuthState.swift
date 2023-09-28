//
//  AuthState.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 27.09.2023.
//

import Foundation

enum AuthState: Int, CaseIterable {
    case registration
    case login
    
    var title: String {
        switch self {
        case .registration:
            AuthConstants.Menu.regText
        case .login:
            AuthConstants.Menu.loginText
        }
    }
}
