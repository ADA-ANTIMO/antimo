//
//  OtherActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension OtherActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OtherActivity> {
        return NSFetchRequest<OtherActivity>(entityName: "OtherActivity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var activity: Activity?

}

extension OtherActivity : Identifiable {

}
