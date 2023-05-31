//
//  Routine+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var weekdays: NSSet?
    @NSManaged public var reminder: Reminder?

    public var getWeekdays: [Weekday] {
        let setOfWeekdays = weekdays as? Set<Weekday> ?? []
        
        return Array(setOfWeekdays)
    }
}

// MARK: Generated accessors for weekdays
extension Routine {

    @objc(addWeekdaysObject:)
    @NSManaged public func addToWeekdays(_ value: Weekday)

    @objc(removeWeekdaysObject:)
    @NSManaged public func removeFromWeekdays(_ value: Weekday)

    @objc(addWeekdays:)
    @NSManaged public func addToWeekdays(_ values: NSSet)

    @objc(removeWeekdays:)
    @NSManaged public func removeFromWeekdays(_ values: NSSet)

}

extension Routine : Identifiable {

}
