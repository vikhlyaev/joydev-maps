//
//  PlaceDetailsConstants.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 21.09.2023.
//

import Foundation

enum PlaceDetailsConstants {
    enum Photo {
        static let height: CGFloat = 300
    }
    
    enum Name {
        static let fontSize: CGFloat = 28
        static let topInset: CGFloat = 16
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Categories {
        static let topInset: CGFloat = 4
        static let leftRightInsets: CGFloat = 16
    }
    
    enum Button {
        static let topInset: CGFloat = 20
        static let leftRightInsets: CGFloat = 16
        static let addFavoriteButtonText = "Добавить в избранное"
        static let removeFavoriteButtonText = "Убрать из избранного"
        static let addFavoriteButtonImageName = "bookmark"
        static let removeFavoriteButtonImageName = "bookmark.fill"
    }
    
    enum Address {
        enum Title {
            static let text = "Адрес"
            static let fontSize: CGFloat = 20
            static let topInset: CGFloat = 28
            static let leftRightInsets: CGFloat = 16
        }
        
        enum Value {
            static let topBottomInsets: CGFloat = 16
            static let leftRightInsets: CGFloat = 16
        }
    }
}
