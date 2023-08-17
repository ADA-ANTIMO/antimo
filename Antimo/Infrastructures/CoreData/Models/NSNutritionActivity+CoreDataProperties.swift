//
//  NSNutritionActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSNutritionActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSNutritionActivity> {
        return NSFetchRequest<NSNutritionActivity>(entityName: "NSNutritionActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isEatenUp: Bool
    @NSManaged public var menu: String?
    @NSManaged public var activity: NSActivity?

}

extension NSNutritionActivity : Identifiable {

}
