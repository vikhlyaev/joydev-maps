//
//  AuthPresenter.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

final class AuthPresenter {
    
    weak var view: AuthInput?
    
}

// MARK: - AuthOutput

extension AuthPresenter: AuthOutput {
    func viewIsReady() {
        print(#function)
    }
}
