//
//  ReminderCoreDataAdapter.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation
import CoreData

class ReminderCoreDataAdapter: ReminderRepository {
  private let coreDataContext = CoreDataConnection.shared.context

  // MARK: Event
  func normalizeNSEventEntity(event: NSEvent) -> Event {
    let reminder = event.reminder!

    return Event(
      id: reminder.id ?? UUID(),
      description: reminder.desc ?? "",
      isActive: reminder.isActive,
      title: reminder.desc ?? "",
      activityType: ActivityTypes(rawValue: reminder.type ?? "") ?? .other,
      createdAt: reminder.createdAt ?? Date(),
      updatedAt: reminder.updatedAt ?? Date(),
      eventId: event.id ?? UUID(),
      triggerDate: event.triggerDate ?? Date()
    )
  }

  func createNewEvent(newEvent: Event) -> Event? {
    // MARK: Creating Reminder
    let reminder = NSReminder(context: coreDataContext)
    reminder.id = newEvent.id
    reminder.title = newEvent.title
    reminder.type = newEvent.activityType.rawValue
    reminder.desc = newEvent.description
    reminder.isActive = newEvent.isActive
    reminder.updatedAt = newEvent.updatedAt
    reminder.createdAt = newEvent.createdAt
    
    // MARK: Creating Event
    let event = NSEvent(context: coreDataContext)
    event.id = newEvent.eventId
    event.reminder = reminder
    event.triggerDate = newEvent.triggerDate

    do {
      try coreDataContext.save()

      return normalizeNSEventEntity(event: event)
    } catch {
      print("Failed creating new event")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func getAllEvents() -> [Event] {
    let request: NSFetchRequest<NSEvent> = NSEvent.fetchRequest()
    var events: [Event] = []

    do {
      let NSEvents = try coreDataContext.fetch(request)

      for NSEvent in NSEvents {
        let event = normalizeNSEventEntity(event: NSEvent)

        events.append(event)
      }

      return events
    } catch {
      print("Failed getting all events")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }

  func getEventById(id: UUID) -> Event? {
    let request: NSFetchRequest<NSEvent> = NSEvent.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let events = try coreDataContext.fetch(request)

      guard let event = events.first else {
        print("No event is found with the provided ID.")
        return nil
      }

      return normalizeNSEventEntity(event: event)
    } catch {
      print("Failed getting event with the provided ID")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func updateEventById(id: UUID, newEvent: Event) -> Event? {
    let request: NSFetchRequest<NSEvent> = NSEvent.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let events = try coreDataContext.fetch(request)

      guard let event = events.first else {
        print("No event is found with the provided ID.")
        return nil
      }

      event.reminder?.type = newEvent.activityType.rawValue
      event.reminder?.title = newEvent.title
      event.reminder?.isActive = newEvent.isActive
      event.reminder?.desc = newEvent.description
      event.reminder?.updatedAt = Date()
      event.triggerDate = newEvent.triggerDate

      try coreDataContext.save()

      return normalizeNSEventEntity(event: event)
    } catch {
      print("Failed updating event")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func updateEventIsActiveStatus(id: UUID, newStatus: Bool) -> Event? {
    let request: NSFetchRequest<NSEvent> = NSEvent.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let events = try coreDataContext.fetch(request)

      guard let event = events.first else {
        print("No event is found with the provided ID.")
        return nil
      }

      event.reminder?.isActive = newStatus
      event.reminder?.updatedAt = Date()

      try coreDataContext.save()

      return normalizeNSEventEntity(event: event)
    } catch {
      print("Failed getting event with the provided ID")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func deleteEventById(id: UUID) -> Event? {
    let request: NSFetchRequest<NSEvent> = NSEvent.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let events = try coreDataContext.fetch(request)

      guard let event = events.first else {
        print("No event is found with the provided ID.")
        return nil
      }

      coreDataContext.delete(event)

      return normalizeNSEventEntity(event: event)
    } catch {
      print("Failed deleting event")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  // MARK: Routine
  func initializeRoutine(newRoutine: Routine) {
    // MARK: Creating Reminder
    let reminder = NSReminder(context: coreDataContext)
    reminder.id = newRoutine.id
    reminder.title = newRoutine.title
    reminder.type = newRoutine.activityType.rawValue
    reminder.desc = newRoutine.description
    reminder.isActive = newRoutine.isActive
    reminder.updatedAt = newRoutine.updatedAt
    reminder.createdAt = newRoutine.createdAt

    // MARK: Creating Routine
    let routine = NSRoutine(context: coreDataContext)
    routine.id = newRoutine.routineId
    routine.reminder = reminder

    // MARK: Adding Weekdays to Routine
    newRoutine.weekdays.forEach { weekday in
      let NSWeekday = NSWeekday(context: coreDataContext)
      NSWeekday.id = weekday.id
      NSWeekday.day = weekday.day.toInt16
      NSWeekday.time = weekday.time

      routine.addToWeekdays(NSWeekday)
    }
  }

  func normalizeNSRoutineEntity(routine: NSRoutine) -> Routine {
    let reminder = routine.reminder!

    let weekdays = routine.getWeekdays.map { weekday in
      return Weekday(id: weekday.id ?? UUID(), day: weekday.day.toInt, time: weekday.time ?? Date())
    }

    return Routine(
      id: reminder.id ?? UUID(),
      description: reminder.desc ?? "",
      isActive: reminder.isActive,
      title: reminder.desc ?? "",
      activityType: ActivityTypes(rawValue: reminder.type ?? "") ?? .other,
      createdAt: reminder.createdAt ?? Date(),
      updatedAt: reminder.updatedAt ?? Date(),
      routineId: routine.id ?? UUID(),
      weekdays: weekdays
    )
  }

  func createNewRoutine(newRoutine: Routine) -> Routine? {
    initializeRoutine(newRoutine: newRoutine)

    do {
      try coreDataContext.save()

      return newRoutine
    } catch {
      print("Failed creating new routine")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func getAllRoutines() -> [Routine] {
    let request: NSFetchRequest<NSRoutine> = NSRoutine.fetchRequest()
    var routines: [Routine] = []

    do {
      let NSRoutines = try coreDataContext.fetch(request)

      for NSRoutine in NSRoutines {
        let routine = normalizeNSRoutineEntity(routine: NSRoutine)

        routines.append(routine)
      }

      return routines
    } catch {
      print("Failed getting all routines")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }

  func getRoutineById(id: UUID) -> Routine? {
    let request: NSFetchRequest<NSRoutine> = NSRoutine.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let routines = try coreDataContext.fetch(request)

      guard let routine = routines.first else {
        print("No routine is found with the provided ID.")
        return nil
      }

      return normalizeNSRoutineEntity(routine: routine)
    } catch {
      print("Failed getting routine with the provided ID")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func updateRoutineById(id: UUID, newRoutine: Routine) -> Routine? {
    let request: NSFetchRequest<NSRoutine> = NSRoutine.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let routines = try coreDataContext.fetch(request)

      guard let routine = routines.first else {
        print("No routine is found with the provided ID.")
        return nil
      }

      coreDataContext.delete(routine)

      initializeRoutine(newRoutine: newRoutine)

      try coreDataContext.save()

      return newRoutine
    } catch {
      print("Failed updating routine")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func updateRoutineIsActiveStatus(id: UUID, newStatus: Bool) -> Routine? {
    let request: NSFetchRequest<NSRoutine> = NSRoutine.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let routines = try coreDataContext.fetch(request)

      guard let routine = routines.first else {
        print("No routine is found with the provided ID.")
        return nil
      }

      routine.reminder?.isActive = newStatus
      routine.reminder?.updatedAt = Date()

      try coreDataContext.save()

      return normalizeNSRoutineEntity(routine: routine)
    } catch {
      print("Failed getting routine with the provided ID")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func deleteRoutineById(id: UUID) -> Routine? {
    let request: NSFetchRequest<NSRoutine> = NSRoutine.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let routines = try coreDataContext.fetch(request)

      guard let routine = routines.first else {
        print("No routine is found with the provided ID.")
        return nil
      }

      coreDataContext.delete(routine)

      return normalizeNSRoutineEntity(routine: routine)
    } catch {
      print("Failed deleting routine")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }
}
