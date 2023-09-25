//
//  AuthConstants.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

enum AuthConstants {
    enum Logo {
        static let imageName = "Logo"
        static let topInset: CGFloat = 100
        static let widthHeight: CGFloat = 150
    }
    
    enum TableView {
        static let cellHeight: CGFloat = 44
        static let topInset: CGFloat = 50
        static let leftRigthInsets: CGFloat = 16
    }
    
    enum LoginButton {
        static let text = "Войти"
        static let bottomInset: CGFloat = 16
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Error {
        static let loginOrPasswordNotFound = "Логин или пароль не получены"
        static let loginOrPasswordIncorrect = "Неверный логин или пароль"
        static let topInset: CGFloat = 16
        static let leftRigthInsets: CGFloat = 16
    }
}
