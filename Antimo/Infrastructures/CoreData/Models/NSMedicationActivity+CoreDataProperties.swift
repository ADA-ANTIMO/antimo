//
//  NSMedicationActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSMedicationActivity {
  @NSManaged public var id: UUID?
  @NSManaged public var vet: String?
  @NSManaged public var activity: NSActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSMedicationActivity> {
    NSFetchRequest<NSMedicationActivity>(entityName: "NSMedicationActivity")
  }

}

// MARK: - NSMedicationActivity + Identifiable

extension NSMedicationActivity: Identifiable { }
