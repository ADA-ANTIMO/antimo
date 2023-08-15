//
//  AntimoApp.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - AntimoApp

@main
struct AntimoApp: App {
  @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

  @StateObject var notificationManager = NotificationsManager()

  @StateObject var dashboardNavigation = DashboardNavigationManager()
  @StateObject var journalNavigation = JournalNavigationManager()
  @StateObject var activityNavigation = ActivityNavigationManager()

  @State private var selectedTab: NavigationTabs = .dashboard

  let persistenceController = PersistenceController.shared

  // TODO: use @AppStorage
  @State var isFirstAppOpen = false

  var body: some Scene {
    WindowGroup {
      if isFirstAppOpen {
        OnboardingView()
      } else {
        ANTabView(
          selectedTab: $selectedTab,
          dashboardNavigation: dashboardNavigation,
          journalNavigation: journalNavigation,
          activityNavigation: activityNavigation)
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
          .onOpenURL { url in
            Task {
              await handleDeeplinking(from: url)
            }
          }
          .onAppear {
            appDelegate.app = self
          }
      }
    }
  }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject, UNUserNotificationCenterDelegate {
  var app: AntimoApp?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool
  {
    UNUserNotificationCenter.current().delegate = self

    return true
  }

  func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
    if
      let deepLink = response.notification.request.content.userInfo["link"] as? String,
      let url = URL(string: deepLink)
    {
      Task {
        await app?.handleDeeplinking(from: url)
      }
      print("✅ found deep link \(deepLink)")
    }
  }

  func userNotificationCenter(
    _: UNUserNotificationCenter,
    willPresent _: UNNotification)
    async -> UNNotificationPresentationOptions
  {
    [.sound, .badge, .list, .banner]
  }
}

extension AntimoApp {
  fileprivate func handleDeeplinking(from url: URL) async {
    let routeFinder = RouteFinder()

    if let route = await routeFinder.find(from: url) {
      switch route {
      case .addJournals:
        selectedTab = .journal
        journalNavigation.push(to: .addJournal)
      case .allEvents:
        selectedTab = .event
        activityNavigation.push(to: .allEvents)
      default:
        selectedTab = .dashboard
        dashboardNavigation.reset()
      }
    }
  }
}
