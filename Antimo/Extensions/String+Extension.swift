//
//  String+Extension.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 12/06/23.
//

import Foundation

extension String {
    var capitalizedFirstLetter: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst()
        // 3
        return firstLetter + remainingLetters
    }
}
