//
//  Event.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

// MARK: - OrderedEvent

struct OrderedEvent {
  var events = [String: [Event]]()
  var keys = [String]()
}

// MARK: - Event

struct Event: Reminder {
  var id: UUID = .init()
  var description: String
  var isActive: Bool
  var title: String
  var activityType: ActivityTypes
  var createdAt: Date = .init()
  var updatedAt: Date = .init()

  // MARK: Event

  var eventId: UUID = .init()
  var triggerDate: Date
}
