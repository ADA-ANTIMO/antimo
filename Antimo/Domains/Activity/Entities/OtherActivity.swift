//
//  OtherActivity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation

struct OtherActivity: Activity {
  var id: UUID = UUID()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = Date()
  var updatedAt: Date = Date()

  // MARK: Other
  var otherId: UUID = UUID()
}
