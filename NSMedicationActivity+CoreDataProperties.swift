//
//  NSMedicationActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//
//

import Foundation
import CoreData


extension NSMedicationActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMedicationActivity> {
        return NSFetchRequest<NSMedicationActivity>(entityName: "NSMedicationActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var vet: String?
    @NSManaged public var activity: NSActivity?

}

extension NSMedicationActivity : Identifiable {

}
