//
//  Activity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 31/05/23.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: String?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var exercise: ExerciseActivity?
    @NSManaged public var grooming: GroomingActivity?
    @NSManaged public var medication: MedicationActivity?
    @NSManaged public var nutrition: NutritionActivity?
    @NSManaged public var other: OtherActivity?
    @NSManaged public var tags: NSSet?

    public var getTags: [Tag] {
        let setOfTags = tags as? Set<Tag> ?? []
        
        return Array(setOfTags)
    }
}

// MARK: Generated accessors for tags
extension Activity {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension Activity : Identifiable {

}
