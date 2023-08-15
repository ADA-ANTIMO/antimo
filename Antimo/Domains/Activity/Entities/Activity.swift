//
//  Activity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

enum ActivityTypes: String {
  case nutrition = "Nutrition"
  case medication = "Medication"
  case exercise = "Exercise"
  case grooming = "Grooming"
  case other = "Other"

  // MARK: Internal
  // TODO: remove this func, use the built-in accessor
  static func getByString(type: String) -> Self {
    switch type {
      case "Nutrition":
        return nutrition
      case "Medication":
        return medication
      case "Exercise":
        return exercise
      case "Grooming":
        return grooming
      default:
        return other
    }
  }
}

protocol Activity: Identifiable {
  var id: UUID { get set }
  var title: String { get set }
  var image: String { get set }
  var note: String { get set }
  var activityType: ActivityTypes { get set }
  var createdAt: Date { get set }
  var updatedAt: Date { get set }
}
