//
//  Activity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

// MARK: - ActivityTypes

enum ActivityTypes: String {
  case nutrition = "Nutrition"
  case medication = "Medication"
  case exercise = "Exercise"
  case grooming = "Grooming"
  case other = "Other"
}

// MARK: - Activity

protocol Activity: Identifiable {
  var id: UUID { get set }
  var title: String { get set }
  var image: String { get set }
  var note: String { get set }
  var activityType: ActivityTypes { get set }
  var createdAt: Date { get set }
  var updatedAt: Date { get set }
}

// MARK: - OrderedActivity

struct OrderedActivity {
  var activities = [String: [any Activity]]()
  var keys = [String]()
}
