//
//  Reminder.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

protocol Reminder: Identifiable {
  var id: UUID { get set }
  var title: String { get set }
  var description: String { get set }
  var isActive: Bool { get set }
  var activityType: ActivityTypes { get set }
  var createdAt: Date { get set }
  var updatedAt: Date { get set }
}
