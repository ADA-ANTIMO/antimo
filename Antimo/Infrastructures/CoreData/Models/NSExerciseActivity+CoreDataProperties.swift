//
//  NSExerciseActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import CoreData
import Foundation

extension NSExerciseActivity {
  @NSManaged public var duration: Int32
  @NSManaged public var id: UUID?
  @NSManaged public var mood: String?
  @NSManaged public var activity: NSActivity?

  @nonobjc
  public class func fetchRequest() -> NSFetchRequest<NSExerciseActivity> {
    NSFetchRequest<NSExerciseActivity>(entityName: "NSExerciseActivity")
  }

}

// MARK: - NSExerciseActivity + Identifiable

extension NSExerciseActivity: Identifiable { }
