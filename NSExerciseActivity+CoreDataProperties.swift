//
//  NSExerciseActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//
//

import Foundation
import CoreData


extension NSExerciseActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSExerciseActivity> {
        return NSFetchRequest<NSExerciseActivity>(entityName: "NSExerciseActivity")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var mood: String?
    @NSManaged public var activity: NSActivity?

}

extension NSExerciseActivity : Identifiable {

}
