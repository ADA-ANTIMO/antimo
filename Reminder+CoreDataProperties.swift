//
//  Reminder+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var event: Event?
    @NSManaged public var routine: Routine?

}

extension Reminder : Identifiable {

}
