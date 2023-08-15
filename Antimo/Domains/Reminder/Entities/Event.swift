//
//  Event.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

struct Event: Reminder {
  var id: UUID = UUID()
  var description: String
  var isActive: Bool
  var title: String
  var activityType: ActivityTypes
  var createdAt: Date
  var updatedAt: Date

  // MARK: Event
  var eventId: UUID = UUID()
  var triggerDate: Date
}
