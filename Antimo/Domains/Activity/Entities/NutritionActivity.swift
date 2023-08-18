//
//  NutritionActivity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation

struct NutritionActivity: Activity {
  var id: UUID = .init()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = .init()
  var updatedAt: Date = .init()

  // MARK: Nutrition

  var nutritionId: UUID = .init()
  var isEatenUp: Bool
  var menu: String
}
