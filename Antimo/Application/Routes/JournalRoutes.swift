//
//  JournalRoutes.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import Combine
import Foundation
import SwiftUI

// MARK: - JournalRoute

enum JournalRoute: String, Hashable {
  case addJournal
}

// MARK: - JournalNavigationManager

class JournalNavigationManager: ObservableObject {
  @Published var journalPaths = NavigationPath()

  func push(to route: JournalRoute) {
    journalPaths.append(route)
  }

  func goBack() {
    journalPaths.removeLast()
  }

  func reset() {
    journalPaths = NavigationPath()
  }
}
