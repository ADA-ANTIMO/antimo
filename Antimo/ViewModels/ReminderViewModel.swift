//
//  ReminderViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import CoreData

struct ReminderDay: Identifiable, Hashable {
    var id: Int { value }
    var value: Int       // 1 to 7 = Sun -> Sat
    var label: String   // The description of the reminder day
    var isSelected: Bool = false
}

@MainActor
class ReminderViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var selectedActivityType: ActivityTypes = .nutrition
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var time: Date = Date()
    @Published var frequency: String = ""
    
    @Published var isReminderFormPresented: Bool = false
    @Published var isDaysSelectorPresented: Bool = false
    
    @Published var reminderDays: [ReminderDay]
    
    var disabledAddRoutineSubmission: Bool {
        return title.isEmpty || selectedDays().isEmpty
    }
    
    init() {
        let days: [ReminderDay] = [
            ReminderDay(value: 1, label: "Every Sunday"),
            ReminderDay(value: 2, label: "Every Monday"),
            ReminderDay(value: 3, label: "Every Tuesday"),
            ReminderDay(value: 4, label: "Every Wednesday"),
            ReminderDay(value: 5, label: "Every Thursday"),
            ReminderDay(value: 6, label: "Every Friday"),
            ReminderDay(value: 7, label: "Every Saturday")
        ]
        reminderDays = days
    }
    
    // MARK: Methods
    
    func toggleSelection(for day: ReminderDay) {
        if let index = reminderDays.firstIndex(where: { $0.id == day.id }) {
            reminderDays[index].isSelected.toggle()
        }
    }
    
    func selectedDays() -> [ReminderDay] {
        return reminderDays.filter { $0.isSelected }
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
        var out: [Int] = []
        for day in weekdays.enumerated() {
            out.append(Int(day.element.day))
        }
        
        return out
    }
    
    func getRenderedFrequency(_ weekdays: [Int]) -> String {
        let weekdaySet: [Int] = [2, 3, 4, 5, 6]
        
        let sortedWeekdays = weekdays.sorted()
            
        if sortedWeekdays == [1, 7] {
            return "Weekend"
        } else if sortedWeekdays == weekdaySet {
            return "Weekday"
        } else {
            let dayNames = sortedWeekdays.map { (weekday) -> String in
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
    
    func toggleActivation(reminder: Reminder,
                          viewContext: NSManagedObjectContext,
                          notificationManager: NotificationsManager,
                          newValue: Bool ) {
        
        reminder.isActive = newValue
        do {
            try viewContext.save()
            if newValue == true {
                let weekdays = reminder.routine?.getWeekdays
                let dateComponentWithSelectedTime = Utilities.getTime(date: weekdays?.first?.time ?? Date())
                
                let selectedHour = dateComponentWithSelectedTime.hour
                let selectedMinute = dateComponentWithSelectedTime.minute
                var selectedReminderDayInInt: [Int] = []
                if let weekdays = weekdays {
                    weekdays.forEach {
                        selectedReminderDayInInt.append(Int($0.day))
                    }
                }
                notificationManager.scheduleReminderNotification(
                    identifier: reminder.id!.uuidString,
                    title: reminder.title ?? "",
                    subtitle: reminder.description,
                    weekdays: selectedReminderDayInInt,
                    hour: selectedHour!,
                    minute: selectedMinute!
                )
            } else {
                notificationManager.removeScheduledNotification([reminder.id?.uuidString ?? ""])
            }
        } catch {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addReminder(viewContext: NSManagedObjectContext, notificationManager: NotificationsManager) -> Void {
        withAnimation {
            let newReminder = Reminder(context: viewContext)

            newReminder.id = UUID()
            newReminder.type = selectedActivityType.rawValue
            newReminder.title = title
            newReminder.desc = desc
            newReminder.isActive = true
            newReminder.createdAt = Date()

            let newRoutine = Routine(context: viewContext)
            newRoutine.id = UUID()
            newRoutine.reminder = newReminder
            
            let dateComponentWithSelectedTime = Utilities.getTime(date: time)
            
            let selectedHour = dateComponentWithSelectedTime.hour
            let selectedMinute = dateComponentWithSelectedTime.minute
            
            let selectedReminderDayInInt = selectedDays().map { day in
                return day.value
            }
            
            for reminderDay in selectedReminderDayInInt {
                let day = Weekday(context: viewContext)
                day.id = UUID()
                day.day = Int16(reminderDay)
                day.time = time
                day.routine = newRoutine

                newRoutine.addToWeekdays(day)
            }
            
            do {
                try viewContext.save()
                
                notificationManager.scheduleReminderNotification(
                    identifier: newReminder.id!.uuidString,
                    title: title,
                    subtitle: desc,
                    weekdays: selectedReminderDayInInt,
                    hour: selectedHour!,
                    minute: selectedMinute!
                )
                
                closeReminderForm()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
