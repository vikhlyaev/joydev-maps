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
        static let topInset: CGFloat = 50
        static let widthHeight: CGFloat = 150
    }
    
    enum Menu {
        static let regText = "Регистрация"
        static let loginText = "Вход"
        static let topInset: CGFloat = 50
        static let leftRightInsets: CGFloat = 16
    }
    
    enum TableView {
        static let cellHeight: CGFloat = 44
        static let topInset: CGFloat = 20
        static let leftRightInsets: CGFloat = 16
    }
    
    enum PolicyAgreement {
        static let text = "Согласен с правилами"
        static let topInset: CGFloat = 20
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Button {
        static let regText = "Зарегистрироваться"
        static let loginText = "Войти"
        static let bottomInset: CGFloat = 16
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Error {
        static let loginOrPasswordNotFound = "Логин или пароль не получены"
        static let loginOrPasswordIncorrect = "Неверный логин или пароль"
        static let nameIncorrect = "Проверьте правильность имени"
        static let emailIncorrect = "Проверьте правильность электронной почты"
        static let passwordIncorrect = "Пароль должен состоять минимум из 6 символов"
        static let repeatPasswordIncorrect = "Пароли не совпадают"
        static let bottomInset: CGFloat = 16
        static let leftRigthInsets: CGFloat = 16
    }
}
