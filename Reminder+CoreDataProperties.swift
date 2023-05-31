//
//  Reminder+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var activityType: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var title: String?
    @NSManaged public var triggerDate: Date?
    @NSManaged public var type: String?
    @NSManaged public var weekdays: NSSet?

    public var getWeekdays: [Weekday] {
        let setOfWeekdays = weekdays as? Set<Weekday> ?? []
        
        return Array(setOfWeekdays)
    }
}

// MARK: Generated accessors for weekdays
extension Reminder {

    @objc(addWeekdaysObject:)
    @NSManaged public func addToWeekdays(_ value: Weekday)

    @objc(removeWeekdaysObject:)
    @NSManaged public func removeFromWeekdays(_ value: Weekday)

    @objc(addWeekdays:)
    @NSManaged public func addToWeekdays(_ values: NSSet)

    @objc(removeWeekdays:)
    @NSManaged public func removeFromWeekdays(_ values: NSSet)

}

extension Reminder : Identifiable {

}
