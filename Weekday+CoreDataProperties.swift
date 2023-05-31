//
//  Weekday+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension Weekday {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weekday> {
        return NSFetchRequest<Weekday>(entityName: "Weekday")
    }

    @NSManaged public var day: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var reminder: Reminder?

}

extension Weekday : Identifiable {

}
