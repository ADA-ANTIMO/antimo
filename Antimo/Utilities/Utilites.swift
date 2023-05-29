//
//  Utilites.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import Foundation

struct Utilities {
    
    // MARK: - Date Utilities
    
    static func formattedDate(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
}
