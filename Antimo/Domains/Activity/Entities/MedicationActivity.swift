//
//  MedicationActivity.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation

struct MedicationActivity: Activity {
  var id: UUID = UUID()
  var title: String
  var image: String
  var note: String
  var activityType: ActivityTypes
  var createdAt: Date = Date()
  var updatedAt: Date = Date()

  // MARK: Medication
  var medicationId: UUID = UUID()
  var vet: String
}
