//
//  ReminderViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import CoreData
import SwiftUI

// MARK: - ReminderDay

struct ReminderDay: Identifiable, Hashable {
  var id: Int { value }
  var value: Int // 1 to 7 = Sun -> Sat
  var label: String // The description of the reminder day
  var isSelected = false
}

// MARK: - ReminderViewModel

@MainActor
class ReminderViewModel: ObservableObject {
  @Published var events: [Event] = []
  @Published var routines: [Routine] = []

  var eventsByDate: OrderedEvent {
    var dictOfEvents = [String: [Event]]()
    var keyOfDict = [String]()

    for event in events {
      let key = Utilities.formattedDate(from: event.triggerDate , format: "EEEE, d MMM yyyy")

      if var dict = dictOfEvents[key] {
        dict.append(event)

        dictOfEvents[key] = dict
      } else {
        keyOfDict.append(key)
        dictOfEvents[key] = [event]
      }
    }

    return OrderedEvent(events: dictOfEvents, keys: keyOfDict)
  }

  private var reminderService = ReminderService(reminderRepository: ReminderCoreDataAdapter())
  private var notificationManager = NotificationsManager.shared

  // MARK: Lifecycle

  init() {
    let days: [ReminderDay] = [
      ReminderDay(value: 1, label: "Every Sunday"),
      ReminderDay(value: 2, label: "Every Monday"),
      ReminderDay(value: 3, label: "Every Tuesday"),
      ReminderDay(value: 4, label: "Every Wednesday"),
      ReminderDay(value: 5, label: "Every Thursday"),
      ReminderDay(value: 6, label: "Every Friday"),
      ReminderDay(value: 7, label: "Every Saturday"),
    ]
    reminderDays = days

    fetchReminders()
  }

  // MARK: Internal
  private func fetchReminders() {
    events = reminderService.getAllEvents().sorted {
      $0.createdAt < $1.createdAt
    }

    routines = reminderService.getAllRoutines().sorted {
      $0.createdAt < $1.createdAt
    }
  }

  // MARK: Routine Properties
  @Published var selectedActivityType: ActivityTypes = .nutrition
  @Published var title = ""
  @Published var desc = ""
  @Published var time: Date = .init()
  @Published var frequency = ""
  @Published var isReminderFormPresented = false
  @Published var isDaysSelectorPresented = false
  @Published var reminderDays: [ReminderDay] = []

  var disabledAddRoutineSubmission: Bool {
    title.isEmpty || selectedDays().isEmpty
  }

  var hasNotificationPermission: Bool {
    notificationManager.hasPermission
  }

  // MARK: Methods

  func requestNotificationPermission() {
    notificationManager.request()
  }

  func toggleSelection(for day: ReminderDay) {
    if let index = reminderDays.firstIndex(where: { $0.id == day.id }) {
      reminderDays[index].isSelected.toggle()
    }
  }

  func selectedDays() -> [ReminderDay] {
    reminderDays.filter { $0.isSelected }
  }

  func openReminderForm() {
    isReminderFormPresented = true
  }

  func closeReminderForm() {
    isReminderFormPresented = false
    resetForm()
  }

  func resetForm() {
    selectedActivityType = .nutrition
    title = ""
    desc = ""
    time = Date()
    frequency = ""
    resetSelectedReminderDays()
  }

  func openDaysSelectorForm() {
    isDaysSelectorPresented = true
  }

  func closeDaysSelectorForm() {
    isDaysSelectorPresented = false
  }

  func resetSelectedReminderDays() {
    for index in reminderDays.indices {
      reminderDays[index].isSelected = false
    }
  }

  func convertWeekDaysObjIntoInt(_ weekdays: [Weekday] = []) -> [Int] {
    weekdays.map { $0.day }
  }

  func getRenderedFrequency(_ weekdays: [Int]) -> String {
    let weekdaySet: [Int] = [2, 3, 4, 5, 6]

    let sortedWeekdays = weekdays.sorted()

    if sortedWeekdays == [1, 7] {
      return "Weekend"
    } else if sortedWeekdays == weekdaySet {
      return "Weekday"
    } else {
      let dayNames = sortedWeekdays.map { weekday -> String in
        switch weekday {
          case 1:
            return "Sun"
          case 2:
            return "Mon"
          case 3:
            return "Tue"
          case 4:
            return "Wed"
          case 5:
            return "Thu"
          case 6:
            return "Fri"
          case 7:
            return "Sat"
          default:
            return "Choose"
        }
      }
      return dayNames.joined(separator: ", ")
    }
  }

  func getRenderedHourAndMinutes(_ date: Date = Date()) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"

    let calendar = Calendar.current
    let components = calendar.dateComponents([.hour, .minute], from: date)

    if let hour = components.hour, let minute = components.minute {
      let renderedHour = hour < 10 ? "0\(hour)" : String(hour)
      let renderedMinutes = minute < 10 ? "0\(minute)" : String(minute)
      return "\(renderedHour):\(renderedMinutes)"
    }

    return "09:00"
  }

  func getIcon(_ iconName: String) -> ActivityIcons {
    switch iconName {
      case "Nutrition":
        return ActivityIcons.nutrition
      case "Medication":
        return ActivityIcons.medication
      case "Exercise":
        return ActivityIcons.exercise
      case "Grooming":
        return ActivityIcons.grooming
      default:
        return ActivityIcons.other
    }
  }

  func updateRoutineIsActiveStatus(id: UUID, newStatus: Bool) {
    guard let updatedRoutine = reminderService.updateRoutineIsActiveStatus(id: id, newStatus: newStatus) else {
      print("Failed updating routine is active status")
      return
    }

    if let index = routines.firstIndex(where: { $0.id == id }) {
      routines[index] = updatedRoutine
    }

    if newStatus {
      let weekdays = updatedRoutine.weekdays
      let dateComponentWithSelectedTime = Utilities.getTime(date: weekdays.first?.time ?? Date())

      let selectedHour = dateComponentWithSelectedTime.hour
      let selectedMinute = dateComponentWithSelectedTime.minute
      var selectedReminderDayInInt: [Int] = []

      weekdays.forEach {
        selectedReminderDayInInt.append(Int($0.day))
      }

      notificationManager.scheduleReminderNotification(
        identifier: updatedRoutine.id.uuidString,
        title: updatedRoutine.title,
        subtitle: updatedRoutine.description,
        weekdays: selectedReminderDayInInt,
        hour: selectedHour!,
        minute: selectedMinute!
      )
    }

    if !newStatus {
      notificationManager.removeScheduledNotification([updatedRoutine.id.uuidString])
    }
  }

  func createNewRoutine() {
    // MARK: Create Weekdays
    let dateComponentWithSelectedTime = Utilities.getTime(date: time)

    let selectedHour = dateComponentWithSelectedTime.hour
    let selectedMinute = dateComponentWithSelectedTime.minute

    let selectedReminderDayInInt = selectedDays().map { day in
      day.value
    }

    let weekdays = selectedReminderDayInInt.map { Weekday(day: $0, time: time) }
    let newRoutine = Routine(description: self.desc, isActive: true, title: self.title, activityType: self.selectedActivityType, weekdays: weekdays)

    guard let routine = reminderService.createNewRoutine(newRoutine: newRoutine) else {
      print("Failed creating routine")

      return
    }

    withAnimation {
      routines.append(routine)
    }

    notificationManager.scheduleReminderNotification(
      identifier: routine.id.uuidString,
      title: title,
      subtitle: desc,
      weekdays: selectedReminderDayInInt,
      hour: selectedHour!,
      minute: selectedMinute!)

    closeReminderForm()
  }

  // MARK: Event Properties
  @Published var eventActivityType: ActivityTypes = .nutrition
  @Published var eventTitle = ""
  @Published var eventDesc = ""
  @Published var eventDate: Date = .init()
  @Published var eventTime: Date = .init()
  @Published var isEventSheetPresented = false
  @Published var isShowSnackBar = false

  var disableAddEventSubmission: Bool {
    eventTitle.isEmpty
  }

  func openEventSheet() {
    isEventSheetPresented = true
  }

  func closeEventSheet() {
    isEventSheetPresented = false
    resetEventSheetForm()
  }

  func resetEventSheetForm() {
    selectedActivityType = .nutrition
    eventTitle = ""
    eventDesc = ""
    eventDate = Date()
    eventTime = Date()
  }

  // TODO: Implement Save
  func saveEvent() {
    closeEventSheet()
    resetEventSheetForm()
    isShowSnackBar.toggle()
  }

  func createNewEvent() {
    let newEvent = Event(description: self.eventDesc, isActive: true, title: self.eventTitle, activityType: self.eventActivityType, triggerDate: self.eventDate)

    guard let event = reminderService.createNewEvent(newEvent: newEvent) else {
      print("Failed creating event")

      return
    }

    withAnimation {
      events.append(event)
    }

    notificationManager.scheduleEventNotification(
      identifier: event.id.uuidString,
      title: event.title,
      subtitle: event.description,
      triggerDate: event.triggerDate
    )

    saveEvent()
  }
}
