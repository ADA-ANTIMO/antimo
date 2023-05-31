//
//  Event+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var triggerDate: Date?
    @NSManaged public var reminder: Reminder?

}

extension Event : Identifiable {

}
