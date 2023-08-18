//
//  NSNutritionActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSNutritionActivity {
  @NSManaged public var id: UUID?
  @NSManaged public var isEatenUp: Bool
  @NSManaged public var menu: String?
  @NSManaged public var activity: NSActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSNutritionActivity> {
    NSFetchRequest<NSNutritionActivity>(entityName: "NSNutritionActivity")
  }

}

// MARK: - NSNutritionActivity + Identifiable

extension NSNutritionActivity: Identifiable { }
