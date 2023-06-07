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
            
        case .authorized,
             .provisional,
             .ephemeral:
            hasPermission = true
        default:
            hasPermission = false
        }
    }
    
    func scheduleEventNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dog"
                content.subtitle = "it looks hungry"
                content.sound = UNNotificationSound.default
                
                // TODO: define proper deeplinks
                let deepLinkURL = URL(string: "antimo://\(DeepLinkURLs.addJournals.rawValue)")!
                content.userInfo = ["link": deepLinkURL.absoluteString]
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // TODO: define proper identifier
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
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
    
    func scheduleReminderNotification() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dog"
                content.subtitle = "it looks hungry"
                content.sound = UNNotificationSound.default
                
                // Trigger Interval
                // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                // MARK: Trigger Calendar, based on date and time values
                let deepLinkURL = URL(string: "antimo://\(DeepLinkURLs.addJournals.rawValue)")!
                content.userInfo = ["link": deepLinkURL.absoluteString]
                
                // Define the weekday range (Monday to Friday)
                let weekdays: [Int] = [2, 3, 4, 5, 6] // Monday = 2, Tuesday = 3, Wednesday = 4, Thursday = 5, Friday = 6
                let weekend: [Int] = [1, 7]
                
                let datesSchedule = [""]

                // Schedule notifications for each weekday
                for day in weekend {
                    var dateComponents = DateComponents()
        //                    dateComponents.weekday = day
                    dateComponents.hour = 16 // Set the desired hour for the notification (in 24-hour format)
                    dateComponents.minute = 14 // Set the desired minute for the notification

                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                    let request = UNNotificationRequest(identifier: "notification_\(day)", content: content, trigger: trigger)
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
