//
//  Activity+CoreDataProperties.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 09/06/23.
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

}

extension Activity : Identifiable {

}

extension Activity {
    var imagePath: String {
        image ?? ""
    }
    
    var uiImage: UIImage {
        if !imagePath.isEmpty,
           let image = FileManager().retrieveImage(with: imagePath) {
            return image
        } else {
            return UIImage(systemName: "photo")!
        }
    }
}
