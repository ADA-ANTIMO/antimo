//
//  NSEvent+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSEvent {
  @NSManaged public var id: UUID?
  @NSManaged public var triggerDate: Date?
  @NSManaged public var reminder: NSReminder?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSEvent> {
    NSFetchRequest<NSEvent>(entityName: "NSEvent")
  }

}

// MARK: - NSEvent + Identifiable

extension NSEvent: Identifiable { }
