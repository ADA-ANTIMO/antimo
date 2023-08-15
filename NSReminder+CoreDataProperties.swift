//
//  NSReminder+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//
//

import Foundation
import CoreData


extension NSReminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSReminder> {
        return NSFetchRequest<NSReminder>(entityName: "NSReminder")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var event: NSEvent?
    @NSManaged public var routine: NSRoutine?

}

extension NSReminder : Identifiable {

}
