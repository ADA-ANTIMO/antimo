//
//  AntimoApp.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

@main
struct AntimoApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    @StateObject var routerManager = NavigationRouter()
    @StateObject var notificationManager = NotificationsManager()
    
    @State private var selectedTab: NavigationTabs = .reminder
    
    let persistenceController = PersistenceController.shared
    
    // TODO: use @AppStorage
    @State var isFirstAppOpen: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isFirstAppOpen {
                OnboardingView()
            } else {
                ANTabView(selectedTab: $selectedTab)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                    .environmentObject(routerManager)
                    .onAppear {
                        appDelegate.app = self
                    }
            }
        }
    }
}

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

private extension AntimoApp {
    
    func handleDeeplinking(from url: URL) async {
        
        //Not as page anymore but a sheet
//        let routeFinder = RouteFinder()
//        if let route = await routeFinder.find(from: url) {
//            switch route {
//            case .addExercise:
//                routerManager.push(to: route)
//            case.addNutrition:
//                routerManager.push(to: route)
//            default:
//                routerManager.push(to: route)
//            }
//        }
    }
}
