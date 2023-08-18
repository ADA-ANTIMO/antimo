//
//  NSPet+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSPet {
  @NSManaged public var createdAt: Date?
  @NSManaged public var id: UUID?
  @NSManaged public var updatedAt: Date?
  @NSManaged public var weight: Int16

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSPet> {
    NSFetchRequest<NSPet>(entityName: "NSPet")
  }

}

// MARK: - NSPet + Identifiable

extension NSPet: Identifiable { }
