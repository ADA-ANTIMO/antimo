//
//  ExerciseActivity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
//
//

import Foundation
import CoreData


extension ExerciseActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseActivity> {
        return NSFetchRequest<ExerciseActivity>(entityName: "ExerciseActivity")
    }

    @NSManaged public var duration: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var mood: String?
    @NSManaged public var activity: Activity?

}

extension ExerciseActivity : Identifiable {

}
