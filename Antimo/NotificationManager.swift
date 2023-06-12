//
//  NotificationManager.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import Foundation
import UserNotifications

@MainActor
class NotificationsManager: ObservableObject {
    // TODO: Decide whether to use a singleton or not
    @Published private(set) var hasPermission = false
    
    init() {
        Task {
            await getAuthStatus()
        }
    }
    
    func removeScheduledNotification(_ identifierToRemove: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifierToRemove)
    }
    
    func request() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("access granted")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getAuthStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings()
        switch status.authorizationStatus {
            case    .authorized,
                    .provisional,
                    .ephemeral:
                hasPermission = true
            default:
                hasPermission = false
        }
    }
    
    func scheduleEventNotification(identifier: String, title: String, subtitle: String, triggerDate: Date) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = title
                content.subtitle = subtitle
                content.sound = UNNotificationSound.default
                
                // TODO: define proper deeplinks
                let deepLinkURL = URL(string: "antimo://\(DeepLinkURLs.allEvents.rawValue)")!
                content.userInfo = ["link": deepLinkURL.absoluteString]
                
                var dateComponents = DateComponents()
                let date = Utilities.getDate(date: triggerDate)
                let hourAndMinutes = Utilities.getTime(date: triggerDate)
                
                dateComponents.year = date.year
                dateComponents.month = date.month
                dateComponents.day = date.day
                
                dateComponents.hour = hourAndMinutes.hour
                dateComponents.minute = hourAndMinutes.minute
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Failed to schedule notification: \(error.localizedDescription)")
                    } else {
                        print("Notification scheduled successfully")
                    }
                }
            } else {
                print("User has not granted permission for notifications")
                // You can show an alert or prompt the user to grant permission
            }
        }
    }
    
    // identifier is routineID
    func scheduleReminderNotification(identifier: String, title: String, subtitle: String, weekdays: [Int], hour: Int, minute: Int) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = title
                content.subtitle = subtitle
                content.sound = UNNotificationSound.default
                
                // MARK: Trigger Calendar, based on date and time values
                let deepLinkURL = URL(string: "antimo://\(DeepLinkURLs.addJournals.rawValue)")!
                content.userInfo = ["link": deepLinkURL.absoluteString]

                // Schedule notifications for each weekday
                for day in weekdays {
                    var dateComponents = DateComponents()
                    dateComponents.weekday = day
                    dateComponents.hour = hour // Set the desired hour for the notification (in 24-hour format)
                    dateComponents.minute = minute // Set the desired minute for the notification

                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: "\(identifier)\(day)", content: content, trigger: trigger)
                    
                    UNUserNotificationCenter.current().add(request) { error in
                        if let error = error {
                            print("Error scheduling notification: \(error.localizedDescription)")
                        } else {
                            print("Notification scheduled successfully for day \(day).")
                        }
                    }
                }
            } else {
                print("User has not granted permission for notifications")
                // You can show an alert or prompt the user to grant permission
            }
        }
    }
}
