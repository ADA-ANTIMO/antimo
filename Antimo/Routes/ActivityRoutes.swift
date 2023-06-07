//
//  ActivityRoutes.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import Foundation
import Combine
import SwiftUI

enum ActivityRoute: String , Hashable {
    case allEvents
    case activitesPerDate
}

class ActivityNavigationManager: ObservableObject{
    
    @Published var activityPaths = NavigationPath()
    
    func push(to route: ActivityRoute) {
        activityPaths.append(route)
    }
    
    func goBack()  {
        activityPaths.removeLast()
    }
    
    func reset() {
        activityPaths = NavigationPath()
    }
}
