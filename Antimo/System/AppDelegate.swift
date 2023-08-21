//
//  AppDelegate.swift
//  Antimo
//
//  Created by Roli Bernanda on 21/08/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject, UNUserNotificationCenterDelegate {
    
    var app: AntimoApp?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
     
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        if let deepLink = response.notification.request.content.userInfo["link"] as? String,
           let url = URL(string: deepLink) {
            Task {
                await app?.handleDeeplinking(from: url)
            }
            print("✅ found deep link \(deepLink)")
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .badge, .list, .banner]
    }
    
}
