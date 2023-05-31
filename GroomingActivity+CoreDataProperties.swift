//
//  GroomingActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension GroomingActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroomingActivity> {
        return NSFetchRequest<GroomingActivity>(entityName: "GroomingActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var salon: String?
    @NSManaged public var satisfaction: Int16
    @NSManaged public var activity: Activity?

}

extension GroomingActivity : Identifiable {

}
