//
//  Routine+Extensions.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

extension NSRoutine {
  public var getWeekdays: [Weekday] {
    let setOfWeekdays = weekdays as? Set<Weekday> ?? []

    return Array(setOfWeekdays)
  }
}
