//
//  StringExtension.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 1/5/22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    // Function for capitalizing the first letter of a string
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
