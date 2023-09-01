//
//  ActivityCoreDataAdapter.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import CoreData
import Foundation

class ActivityCoreDataAdapter: ActivityRepository {

  // MARK: Internal

  func initializeActivity(activity: some Activity) -> ActivityMO {
    let ActivityMO = ActivityMO(context: coreDataContext)
      ActivityMO.id = activity.id
      ActivityMO.title = activity.title
      ActivityMO.type = activity.activityType.rawValue
      ActivityMO.note = activity.note
      ActivityMO.image = activity.image
      ActivityMO.updatedAt = activity.updatedAt
      ActivityMO.createdAt = activity.createdAt

    return ActivityMO
  }

  func normalizeActivity(activity: ActivityMO) -> any Activity {
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
        mood: Mood(rawValue: exercise.mood!)!)
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
        satisfaction: grooming.satisfaction ?? "")
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
        vet: medication.vet ?? "")
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
        menu: nutrition.menu ?? "")
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
        otherId: other.id ?? UUID())
    }
  }

  /// Mutating the managed core data activity object
  ///
  /// Use this method to mutate the base activity properties
  /// - Parameter ActivityMO: `ActivityMO` you want to mutate
  /// - Parameter activity: `Activity` that is the source of mutation
  func mutateActivity(NSActivity: ActivityMO, activity: any Activity) {
    NSActivity.title = activity.title
    NSActivity.type = activity.activityType.rawValue
    NSActivity.note = activity.note
    NSActivity.image = activity.image
    NSActivity.updatedAt = activity.updatedAt
  }

    func getActivityById(id: UUID) throws -> ActivityMO {
        enum ActivityError: Error {
            case notFound
        }
        
        let request: NSFetchRequest<ActivityMO> = ActivityMO.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let ActivitiesMO = try coreDataContext.fetch(request)
        
        guard let ActivityMO = ActivitiesMO.first else {
            throw ActivityError.notFound
        }
        
        return ActivityMO
    }

  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity? {
    let ActivityMO = initializeActivity(activity: activity)

    let exercise = ExerciseActivityMO(context: coreDataContext)
    exercise.id = activity.exerciseId
    exercise.activity = ActivityMO
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

  func getAllExerciseActivitiesByDateRange(startDate: Date, endDate: Date) -> [ExerciseActivity] {
    var activities: [ExerciseActivity] = []

    let request: NSFetchRequest<ActivityMO> = ActivityMO.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "createdAt", ascending: false),
    ]
    request.predicate = NSPredicate(
      format: "(createdAt >= %@) AND (createdAt <= %@) AND (type == %@)",
      startDate as CVarArg,
      endDate as CVarArg,
      "Exercise")

    do {
      let NSActivities = try coreDataContext.fetch(request)

      for NSActivity in NSActivities {
        let activity = normalizeActivity(activity: NSActivity) as! ExerciseActivity // swiftlint:disable:this force_cast

        activities.append(activity)
      }

      return activities
    } catch {
      print("Failed getting exercise activities")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }

  func updateExerciseActivityById(id: UUID, activity: ExerciseActivity) -> ExerciseActivity? {
    do {
      let NSActivity = try getActivityById(id: id)

      mutateActivity(NSActivity: NSActivity, activity: activity)
      NSActivity.exercise?.duration = activity.duration.toInt32
      NSActivity.exercise?.mood = activity.mood.rawValue

      try coreDataContext.save()

      return activity
    } catch {
      print("Failed updating activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity? {
    let ActivityMO = initializeActivity(activity: activity)

    let grooming = GroomingActivityMO(context: coreDataContext)
    grooming.id = activity.groomingId
    grooming.activity = ActivityMO
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

  func updateGroomingActivityById(id: UUID, activity: GroomingActivity) -> GroomingActivity? {
    do {
      let NSActivity = try getActivityById(id: id)

      mutateActivity(NSActivity: NSActivity, activity: activity)
      NSActivity.grooming?.salon = activity.salon
      NSActivity.grooming?.satisfaction = activity.satisfaction

      try coreDataContext.save()

      return activity
    } catch {
      print("Failed updating activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let medication = MedicationActivityMO(context: coreDataContext)
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

  func updateMedicationActivityById(id: UUID, activity: MedicationActivity) -> MedicationActivity? {
    do {
      let ActivityMO = try getActivityById(id: id)

      mutateActivity(NSActivity: ActivityMO, activity: activity)
      ActivityMO.medication?.vet = activity.vet

      try coreDataContext.save()

      return activity
    } catch {
      print("Failed updating activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity? {
    let ActivityMO = initializeActivity(activity: activity)

    let nutrition = NutritionActivityMO(context: coreDataContext)
    nutrition.id = activity.nutritionId
    nutrition.activity = ActivityMO
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

  func updateNutritionActivityById(id: UUID, activity: NutritionActivity) -> NutritionActivity? {
    do {
      let NSActivity = try getActivityById(id: id)

      mutateActivity(NSActivity: NSActivity, activity: activity)
      NSActivity.nutrition?.isEatenUp = activity.isEatenUp
      NSActivity.nutrition?.menu = activity.menu

      try coreDataContext.save()

      return activity
    } catch {
      print("Failed updating activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity? {
    let NSActivity = initializeActivity(activity: activity)

    let other = OtherActivityMO(context: coreDataContext)
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

  func updateOtherActivityById(id: UUID, activity: OtherActivity) -> OtherActivity? {
    do {
      let NSActivity = try getActivityById(id: id)

      mutateActivity(NSActivity: NSActivity, activity: activity)

      try coreDataContext.save()

      return activity
    } catch {
      print("Failed updating activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func getAllActivitiesByDateRange(startDate: Date, endDate: Date) -> [any Activity] {
    var activities: [any Activity] = []

    let request: NSFetchRequest<ActivityMO> = ActivityMO.fetchRequest()
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
      print("Failed getting all activities")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }

  func deleteActivityById(id: UUID) -> (any Activity)? {
    let request: NSFetchRequest<ActivityMO> = ActivityMO.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

    do {
      let activities = try coreDataContext.fetch(request)

      guard let activity = activities.first else {
        print("No activity is found with the provided ID.")
        return nil
      }

      coreDataContext.delete(activity)

      return normalizeActivity(activity: activity)
    } catch {
      print("Failed deleting activity")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  // MARK: Private

  private let coreDataContext = PersistenceController.shared.context

}
