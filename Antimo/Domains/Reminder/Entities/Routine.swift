//
//  Routine.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

struct Routine: Reminder {
  var id: UUID = .init()
  var description: String
  var isActive: Bool
  var title: String
  var activityType: ActivityTypes
  var createdAt: Date = .init()
  var updatedAt: Date = .init()

  // MARK: Routine

  var routineId: UUID = .init()
  var weekdays: [Weekday]
}
