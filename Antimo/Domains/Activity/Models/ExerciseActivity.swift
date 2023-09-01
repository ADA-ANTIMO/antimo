//
//  ExerciseActivity.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

struct ExerciseActivity: Activity {
  var id: UUID = .init()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = .init()
  var updatedAt: Date = .init()

  // MARK: Exercise

  var exerciseId: UUID = .init()
  var duration: Int
  var mood: Mood
}
