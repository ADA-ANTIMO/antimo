//
//  Route.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import Foundation
import SwiftUI

// TODO: Find out how to present AddAcitivityView dynamically: exercise, nutrition, etc..
enum Route: View, Hashable {
    case dashboard
    case reminder
    case summary
    case profile
    case addActivities
    case addExercise
    case addNutrition
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.dashboard, .dashboard):
            return true
        case (.reminder, .reminder):
            return true
        case (.summary, .summary):
            return true
        case (.profile, .profile):
            return true
        case (.addActivities, .addActivities):
            return true
        case (.addExercise, .addExercise):
            return true
        case (.addNutrition, .addNutrition):
            return true
        default:
            return false
            
        }
    }
    
    var body: some View {
        switch self {
        case .dashboard:
            DashboardView()
        case .addActivities:
            AddActivityView()
        case .reminder:
            ReminderView()
        case .profile:
            ProfileView()
        case .summary:
            SummaryView()
        case .addExercise:
            AddExerciseView()
        case .addNutrition:
            AddNutritionView()
        }
    }
}
