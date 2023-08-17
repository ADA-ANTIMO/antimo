//
//  ActivityCoreDataAdapter.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation

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
}
