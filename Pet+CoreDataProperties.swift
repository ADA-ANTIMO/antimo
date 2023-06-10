//
//  Pet+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 10/06/23.
//
//

import Foundation
import CoreData


extension Pet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pet> {
        return NSFetchRequest<Pet>(entityName: "Pet")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var weight: Int16
    @NSManaged public var createdAt: Date?

}

extension Pet : Identifiable {

}
