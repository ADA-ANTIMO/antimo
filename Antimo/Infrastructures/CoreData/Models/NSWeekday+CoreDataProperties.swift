//
//  NSWeekday+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSWeekday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSWeekday> {
        return NSFetchRequest<NSWeekday>(entityName: "NSWeekday")
    }

    @NSManaged public var day: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var routine: NSRoutine?

}

extension NSWeekday : Identifiable {

}
