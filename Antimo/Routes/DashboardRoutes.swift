//
//  DashboardRoutes.swift
//  Antimo
//
//  Created by Roli Bernanda on 12/06/23.
//

import Foundation
import Combine
import SwiftUI

enum DashboardRoute: Hashable {
    case allEvents
}

class DashboardNavigationManager: ObservableObject{
    
    @Published var dashboardPaths = NavigationPath()
    
    func push(to route: DashboardRoute) {
        dashboardPaths.append(route)
    }
    
    func goBack()  {
        dashboardPaths.removeLast()
    }
    
    func reset() {
        dashboardPaths = NavigationPath()
    }
}
