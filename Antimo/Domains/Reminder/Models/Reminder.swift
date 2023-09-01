//
//  Reminder.swift
//  Antimo
//
//  Created by Roli Bernanda on 21/08/23.
//

import Foundation

protocol Reminder: Identifiable {
  var id: UUID { get set }
  var title: String { get set }
  var description: String { get set }
  var isActive: Bool { get set }
  var activityType: ActivityTypes { get set }
  var createdAt: Date { get set }
  var updatedAt: Date { get set }
}

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

struct Weekday: Identifiable {
  var id: UUID = .init()
  var day: Int
  var time: Date
}
