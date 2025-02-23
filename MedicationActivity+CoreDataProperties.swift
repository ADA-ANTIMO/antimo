//
//  MedicationActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 10/06/23.
//
//

import Foundation
import CoreData


extension MedicationActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicationActivity> {
        return NSFetchRequest<MedicationActivity>(entityName: "MedicationActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var vet: String?
    @NSManaged public var activity: Activity?

}

extension MedicationActivity : Identifiable {

}
