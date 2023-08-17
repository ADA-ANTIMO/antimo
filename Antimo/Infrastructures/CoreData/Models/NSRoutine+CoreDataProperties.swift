//
//  NSRoutine+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSRoutine> {
        return NSFetchRequest<NSRoutine>(entityName: "NSRoutine")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var reminder: NSReminder?
    @NSManaged public var weekdays: NSSet?

}

// MARK: Generated accessors for weekdays
extension NSRoutine {

    @objc(addWeekdaysObject:)
    @NSManaged public func addToWeekdays(_ value: NSWeekday)

    @objc(removeWeekdaysObject:)
    @NSManaged public func removeFromWeekdays(_ value: NSWeekday)

    @objc(addWeekdays:)
    @NSManaged public func addToWeekdays(_ values: NSSet)

    @objc(removeWeekdays:)
    @NSManaged public func removeFromWeekdays(_ values: NSSet)

}

extension NSRoutine : Identifiable {

}
