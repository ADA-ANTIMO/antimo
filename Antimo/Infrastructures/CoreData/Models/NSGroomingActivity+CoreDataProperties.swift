//
//  NSGroomingActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSGroomingActivity {
  @NSManaged public var id: UUID?
  @NSManaged public var salon: String?
  @NSManaged public var satisfaction: String?
  @NSManaged public var activity: NSActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSGroomingActivity> {
    NSFetchRequest<NSGroomingActivity>(entityName: "NSGroomingActivity")
  }

}

// MARK: - NSGroomingActivity + Identifiable

extension NSGroomingActivity: Identifiable { }
