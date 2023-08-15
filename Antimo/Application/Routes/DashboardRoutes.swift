//
//  DashboardRoutes.swift
//  Antimo
//
//  Created by Roli Bernanda on 12/06/23.
//

import Combine
import Foundation
import SwiftUI

// MARK: - DashboardRoute

enum DashboardRoute: Hashable {
  case allEvents
}

// MARK: - DashboardNavigationManager

class DashboardNavigationManager: ObservableObject {
  @Published var dashboardPaths = NavigationPath()

  func push(to route: DashboardRoute) {
    dashboardPaths.append(route)
  }

  func goBack() {
    dashboardPaths.removeLast()
  }

  func reset() {
    dashboardPaths = NavigationPath()
  }
}
