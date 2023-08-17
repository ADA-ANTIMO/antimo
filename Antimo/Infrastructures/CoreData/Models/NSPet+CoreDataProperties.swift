//
//  NSPet+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSPet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSPet> {
        return NSFetchRequest<NSPet>(entityName: "NSPet")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var weight: Int16

}

extension NSPet : Identifiable {

}
