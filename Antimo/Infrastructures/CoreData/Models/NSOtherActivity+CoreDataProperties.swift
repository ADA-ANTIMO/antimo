//
//  NSOtherActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//
//

import Foundation
import CoreData


extension NSOtherActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSOtherActivity> {
        return NSFetchRequest<NSOtherActivity>(entityName: "NSOtherActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var activity: NSActivity?

}

extension NSOtherActivity : Identifiable {

}
