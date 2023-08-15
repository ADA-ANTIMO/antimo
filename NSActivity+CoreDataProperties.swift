//
//  NSActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//
//

import Foundation
import CoreData


extension NSActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSActivity> {
        return NSFetchRequest<NSActivity>(entityName: "NSActivity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var exercise: NSExerciseActivity?
    @NSManaged public var grooming: NSGroomingActivity?
    @NSManaged public var medication: NSMedicationActivity?
    @NSManaged public var nutrition: NSNutritionActivity?
    @NSManaged public var other: NSOtherActivity?

}

extension NSActivity : Identifiable {

}
