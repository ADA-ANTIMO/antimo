//
//  Utilites.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import Foundation

struct Utilities {
    enum Round {
        case up, down
    }
    // MARK: - Date Utilities
    static func formattedDate(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func safeDivideIntRounded(num1:Int, num2:Int, rounded:Round = .up) -> Int {
        let num1f = Float(num1)
        let num2f = Float(num2)
        
        switch rounded {
            case .up:
                return Int(ceilf(num1f/num2f))
            case .down:
                return Int(floorf(num1f/num2f))
            }
    }
    
    
}
