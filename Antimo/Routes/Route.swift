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
    case summary
    case journal
    case activity
    case reminder
    case addJournals
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.summary, .summary):
            return true
        case (.journal, .journal):
            return true
        case (.activity, .activity):
            return true
        case (.reminder, .reminder):
            return true
        case (.addJournals, .addJournals):
            return true
        default:
            return false
            
        }
    }
    
    var body: some View {
        switch self {
        case .summary:
            SummaryView()
        case .journal:
            JournalView()
        case .activity:
            ActivityView()
        case .reminder:
            ReminderView()
        case .addJournals:
            AddJournalView()
        }
    }
}
