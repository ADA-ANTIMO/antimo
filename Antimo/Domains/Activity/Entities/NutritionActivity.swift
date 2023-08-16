//
//  NutritionActivity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation

struct NutritionActivity: Activity {
  var id: UUID = UUID()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = Date()
  var updatedAt: Date = Date()

  // MARK: Nutrition
  var nutritionId: UUID = UUID()
  var isEatenUp: Bool
  var menu: String
}
