//
//  NSEvent+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSEvent> {
        return NSFetchRequest<NSEvent>(entityName: "NSEvent")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var triggerDate: Date?
    @NSManaged public var reminder: NSReminder?

}

extension NSEvent : Identifiable {

}
