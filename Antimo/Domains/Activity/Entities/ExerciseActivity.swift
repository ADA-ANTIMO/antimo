//
//  ExerciseActivity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

struct ExerciseActivity: Activity {
  var id: UUID = UUID()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = Date()
  var updatedAt: Date = Date()

  // MARK: Exercise
  var exerciseId: UUID = UUID()
  var duration: Int
  var mood: Mood
}
