//
//  NSRoutine+Extensions.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

extension NSRoutine {
  public var getWeekdays: [NSWeekday] {
    let setOfWeekdays = weekdays as? Set<NSWeekday> ?? []

    return Array(setOfWeekdays)
  }
}
