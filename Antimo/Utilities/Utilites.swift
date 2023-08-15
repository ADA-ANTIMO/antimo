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

  enum Swipe {
    case up
    case down
    case left
    case right
    case unknown

    // MARK: Internal

    static func direction(width: CGFloat, height: CGFloat) -> Swipe {
      switch (width, height) {
      case (-100 ... 100, ...0):
        return .up
      case (-100 ... 100, 0...):
        return .down
      case (...0, -30 ... 30):
        return .left
      case (0..., -30 ... 30):
        return .right
      default:
        return .unknown
      }
    }
  }

  // MARK: - Date Utilities

  static func formattedDate(from date: Date, format: String = "d MMM yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
  }

  static func safeDivideIntRounded(num1: Int, num2: Int, rounded: Round = .up) -> Int {
    let num1f = Float(num1)
    let num2f = Float(num2)

    switch rounded {
    case .up:
      return Int(ceilf(num1f / num2f))
    case .down:
      return Int(floorf(num1f / num2f))
    }
  }

  static func convertTo24HourFormat(date: Date) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    return dateFormatter.string(from: date)
  }

  static func getTime(date: Date) -> DateComponents {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)

    return components
  }

  static func getDate(date: Date) -> DateComponents {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day, .month, .year], from: date)

    return components
  }

  static func createDate(date: DateComponents, time: DateComponents) -> Date {
    var components = DateComponents()
    components.year = date.year
    components.month = date.month
    components.day = date.day
    components.hour = time.hour
    components.minute = time.minute

    return Calendar.current.date(from: components) ?? Date()
  }
}
