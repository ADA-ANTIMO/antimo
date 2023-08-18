//
//  NSReminder+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSReminder {
  @NSManaged public var createdAt: Date?
  @NSManaged public var desc: String?
  @NSManaged public var id: UUID?
  @NSManaged public var isActive: Bool
  @NSManaged public var title: String?
  @NSManaged public var type: String?
  @NSManaged public var updatedAt: Date?
  @NSManaged public var event: NSEvent?
  @NSManaged public var routine: NSRoutine?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSReminder> {
    NSFetchRequest<NSReminder>(entityName: "NSReminder")
  }

}

// MARK: - NSReminder + Identifiable

extension NSReminder: Identifiable { }
