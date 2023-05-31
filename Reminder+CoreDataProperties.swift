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

    @NSManaged public var type: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var title: String?
    @NSManaged public var routine: Routine?
    @NSManaged public var event: Event?

}

extension Reminder : Identifiable {

}
