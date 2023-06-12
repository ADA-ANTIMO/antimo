//
//  ActivityViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import SwiftUI
import CoreData

@MainActor
class ActivityViewModel: ObservableObject {
    @Published var selectedActivityType: ActivityTypes = .nutrition
    @Published var eventTitle: String = ""
    @Published var eventDesc: String = ""
    @Published var eventDate: Date = Date()
    @Published var eventTime: Date = Date()
    
    @Published var isEventSheetPresented: Bool = false
    @Published var isShowSnackBar: Bool = false
    
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
    
    func addEvent(viewContext: NSManagedObjectContext, notificationManager: NotificationsManager) {
        let newReminder = Reminder(context: viewContext)

        newReminder.id = UUID()
        newReminder.type = selectedActivityType.rawValue
        newReminder.title = eventTitle
        newReminder.desc = eventDesc
        newReminder.isActive = true
        newReminder.createdAt = Date()
        
        
        let newEvent = Event(context: viewContext)
        newEvent.id = UUID()
        newEvent.reminder = newReminder
        
        let triggerDate = Utilities.createDate(
            date: Utilities.getDate(date: eventDate),
            time: Utilities.getTime(date: eventTime)
        )
        
        newEvent.triggerDate = triggerDate
        
        newReminder.event = newEvent
        
        do {
            try viewContext.save()
            
            notificationManager.scheduleEventNotification(
                identifier: newReminder.id!.uuidString,
                title: newReminder.title!,
                subtitle: newReminder.desc!,
                triggerDate: newEvent.triggerDate!
            )
            
            
            saveEvent()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
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
    
}
