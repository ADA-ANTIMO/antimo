//
//  GroomingActivity.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

struct GroomingActivity: Activity {
  var id: UUID = .init()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = .init()
  var updatedAt: Date = .init()

  // MARK: Grooming

  var groomingId: UUID = .init()
  var salon: String
  var satisfaction: String
}
