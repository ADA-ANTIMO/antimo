//
//  NSGroomingActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//
//

import Foundation
import CoreData


extension NSGroomingActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSGroomingActivity> {
        return NSFetchRequest<NSGroomingActivity>(entityName: "NSGroomingActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var salon: String?
    @NSManaged public var satisfaction: String?
    @NSManaged public var activity: NSActivity?

}

extension NSGroomingActivity : Identifiable {

}
