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

  @StateObject var journalViewModel = JournalViewModel()
  @StateObject var summaryViewModel = SummaryViewModel()
  @StateObject var reminderViewModel = ReminderViewModel()

  @StateObject var dashboardNavigation = DashboardNavigationManager()
  @StateObject var journalNavigation = JournalNavigationManager()
  @StateObject var activityNavigation = ActivityNavigationManager()

  @State private var selectedTab: NavigationTabs = .dashboard

  // TODO: use @AppStorage
  @State var isFirstAppOpen = false

  var body: some Scene {
    WindowGroup {
      if isFirstAppOpen {
        OnboardingView()
      } else {
        ANTabView(selectedTab: $selectedTab)
          .environmentObject(dashboardNavigation)
          .environmentObject(journalNavigation)
          .environmentObject(activityNavigation)
          .environmentObject(journalViewModel)
          .environmentObject(summaryViewModel)
          .environmentObject(reminderViewModel)
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

extension AntimoApp {
 func handleDeeplinking(from url: URL) async {
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
