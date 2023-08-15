//
//  ActivityRoutes.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import SwiftUI

// MARK: - ActivityRoute

enum ActivityRoute: Hashable {
  case allEvents
  case activitesPerDate(Date)
  case addJournal
}

// MARK: - ActivityNavigationManager

class ActivityNavigationManager: ObservableObject {
  @Published var activityPaths = NavigationPath()

  func push(to route: ActivityRoute) {
    activityPaths.append(route)
  }

  func goBack() {
    activityPaths.removeLast()
  }

  func reset() {
    activityPaths = NavigationPath()
  }
}
