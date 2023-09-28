//
//  String + Extensions.swift
//  Joy Dev Maps
//
//  Created by Anton Vikhlyaev on 25.09.2023.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        return firstLetter + remainingLetters
    }
}
