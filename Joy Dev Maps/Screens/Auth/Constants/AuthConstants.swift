//
//  AuthConstants.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import UIKit

enum AuthConstants {
    static let logoImageViewImage = UIImage(named: "Logo")
    static let loginButtonText = "Войти"
    static let errorLoginAndPasswordNotFound = "Логин или пароль не получены"
    static let errorLoginAndPasswordIncorrect = "Неверный логин или пароль"
    
    enum Logo {
        static let topInset: CGFloat = 100
        static let widthHeight: CGFloat = 150
    }
    
    enum TableView {
        static let cellHeight: CGFloat = 44
        static let topInset: CGFloat = 50
        static let leftRigthInsets: CGFloat = 16
    }
    
    enum LoginButton {
        static let bottomInset: CGFloat = 16
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Error {
        static let topInset: CGFloat = 16
        static let leftRigthInsets: CGFloat = 16
    }
}
