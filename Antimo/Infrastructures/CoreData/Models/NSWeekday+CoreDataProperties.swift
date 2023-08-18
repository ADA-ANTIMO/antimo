//
//  NSWeekday+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSWeekday {
  @NSManaged public var day: Int16
  @NSManaged public var id: UUID?
  @NSManaged public var time: Date?
  @NSManaged public var routine: NSRoutine?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSWeekday> {
    NSFetchRequest<NSWeekday>(entityName: "NSWeekday")
  }

}

// MARK: - NSWeekday + Identifiable

extension NSWeekday: Identifiable { }
