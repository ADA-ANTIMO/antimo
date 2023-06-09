//
//  NutritionActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
//
//

import Foundation
import CoreData


extension NutritionActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NutritionActivity> {
        return NSFetchRequest<NutritionActivity>(entityName: "NutritionActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isEatenUp: Bool
    @NSManaged public var menu: String?
    @NSManaged public var activity: Activity?

}

extension NutritionActivity : Identifiable {

}
