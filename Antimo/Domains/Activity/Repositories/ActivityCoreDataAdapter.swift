//
//  ActivityCoreDataAdapter.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation
import CoreData

class ActivityCoreDataAdapter: ActivityRepository {
  private let coreDataContext = CoreDataConnection.shared.context

  func initializeActivity<T: Activity>(activity: T) -> NSActivity {
    let NSActivity = NSActivity(context: coreDataContext)
    NSActivity.id = activity.id
    NSActivity.title = activity.title
    NSActivity.type = activity.activityType.rawValue
    NSActivity.note = activity.note
    NSActivity.image = activity.image
    NSActivity.updatedAt = activity.updatedAt
    NSActivity.createdAt = activity.createdAt

    return NSActivity
  }

  func normalizeActivity(activity: NSActivity) -> any Activity {
    let id = activity.id ?? UUID()
    let title = activity.title ?? ""
    let image = activity.image ?? ""
    let note = activity.note ?? ""
    let activityType = ActivityTypes(rawValue: activity.type!)!
    let createdAt = activity.createdAt ?? Date()
    let updatedAt = activity.updatedAt ?? Date()

    switch activityType {
      case .exercise:
        let exercise = activity.exercise!

        return ExerciseActivity(
          id: id,
          title: title,
          image: image,
          note: note,
          activityType: activityType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          exerciseId: exercise.id ?? UUID(),
          duration: exercise.duration.toInt,
          mood: Mood(rawValue: exercise.mood!)!
        )
      case .grooming:
        let grooming = activity.grooming!

        return GroomingActivity(
          id: id,
          title: title,
          image: image,
          note: note,
          activityType: activityType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          groomingId: grooming.id ?? UUID(),
          salon: grooming.salon ?? "",
          satisfaction: grooming.satisfaction ?? ""
        )
      case .medication:
        let medication = activity.medication!

        return MedicationActivity(
          id: id,
          title: title,
          image: image,
          note: note,
          activityType: activityType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          medicationId: medication.id ?? UUID(),
          vet: medication.vet ?? ""
        )
      case .nutrition:
        let nutrition = activity.nutrition!

        return NutritionActivity(
          id: id,
          title: title,
          image: image,
          note: note,
          activityType: activityType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          nutritionId: nutrition.id ?? UUID(),
          isEatenUp: nutrition.isEatenUp,
          menu: nutrition.menu ?? ""
        )
      case .other:
        let other = activity.other!

        return OtherActivity(
          id: id,
          title: title,
          image: image,
          note: note,
          activityType: activityType,
          createdAt: createdAt,
          updatedAt: updatedAt,
          otherId: other.id ?? UUID()
        )
    }
  }

  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let exercise = NSExerciseActivity(context: coreDataContext)
    exercise.id = activity.exerciseId
    exercise.activity = NSActivity
    exercise.duration = activity.duration.toInt32
    exercise.mood = activity.mood.rawValue

    do {
      try coreDataContext.save()

      return activity
    } catch {
      print("Failed creating new activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let grooming = NSGroomingActivity(context: coreDataContext)
    grooming.id = activity.groomingId
    grooming.activity = NSActivity
    grooming.salon = activity.salon
    grooming.satisfaction = activity.satisfaction

    do {
      try coreDataContext.save()

      return activity
    } catch {
      print("Failed creating new activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let medication = NSMedicationActivity(context: coreDataContext)
    medication.id = activity.medicationId
    medication.activity = NSActivity
    medication.vet = activity.vet

    do {
      try coreDataContext.save()

      return activity
    } catch {
      print("Failed creating new activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let nutrition = NSNutritionActivity(context: coreDataContext)
    nutrition.id = activity.nutritionId
    nutrition.activity = NSActivity
    nutrition.isEatenUp = activity.isEatenUp
    nutrition.menu = activity.menu

    do {
      try coreDataContext.save()

      return activity
    } catch {
      print("Failed creating new activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let other = NSOtherActivity(context: coreDataContext)
    other.id = activity.otherId
    other.activity = NSActivity

    do {
      try coreDataContext.save()

      return activity
    } catch {
      print("Failed creating new activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func getAllActivitiesByDateRange(startDate: Date, endDate: Date) -> [any Activity] {
    var activities: [any Activity] = []

    let request: NSFetchRequest<NSActivity> = NSActivity.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "createdAt", ascending: false),
    ]
    request.predicate = NSPredicate(
      format: "(createdAt >= %@) AND (createdAt <= %@)",
      startDate as CVarArg,
      endDate as CVarArg)

    do {
      let NSActivities = try coreDataContext.fetch(request)

      for NSActivity in NSActivities {
        let activity = normalizeActivity(activity: NSActivity)

        activities.append(activity)
      }

      return activities
    } catch {
      print("Failed getting all routines")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }
}
