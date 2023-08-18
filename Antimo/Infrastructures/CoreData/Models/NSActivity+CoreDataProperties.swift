//
//  NSActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSActivity {
  @NSManaged public var createdAt: Date?
  @NSManaged public var id: UUID?
  @NSManaged public var image: String?
  @NSManaged public var note: String?
  @NSManaged public var title: String?
  @NSManaged public var type: String?
  @NSManaged public var updatedAt: Date?
  @NSManaged public var exercise: NSExerciseActivity?
  @NSManaged public var grooming: NSGroomingActivity?
  @NSManaged public var medication: NSMedicationActivity?
  @NSManaged public var nutrition: NSNutritionActivity?
  @NSManaged public var other: NSOtherActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSActivity> {
    NSFetchRequest<NSActivity>(entityName: "NSActivity")
  }

}

// MARK: - NSActivity + Identifiable

extension NSActivity: Identifiable { }
