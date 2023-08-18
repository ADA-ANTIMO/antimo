//
//  ActivityService.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation

class ActivityService {

  // MARK: Lifecycle

  init(activityRepository: ActivityRepository) {
    self.activityRepository = activityRepository
  }

  // MARK: Internal

  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity? {
    activityRepository.createNewNutritionActivity(activity: activity)
  }

  func updateNutritionActivityById(id: UUID, activity: NutritionActivity) -> NutritionActivity? {
    activityRepository.updateNutritionActivityById(id: id, activity: activity)
  }

  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity? {
    activityRepository.createNewExerciseActivity(activity: activity)
  }

  func getAllExerciseActivitiesByDateRange(startDate: Date, endDate: Date) -> [ExerciseActivity] {
    activityRepository.getAllExerciseActivitiesByDateRange(startDate: startDate, endDate: endDate)
  }

  func updateExerciseActivityById(id: UUID, activity: ExerciseActivity) -> ExerciseActivity? {
    activityRepository.updateExerciseActivityById(id: id, activity: activity)
  }

  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity? {
    activityRepository.createNewMedicationActivity(activity: activity)
  }

  func updateMedicationActivityById(id: UUID, activity: MedicationActivity) -> MedicationActivity? {
    activityRepository.updateMedicationActivityById(id: id, activity: activity)
  }

  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity? {
    activityRepository.createNewGroomingActivity(activity: activity)
  }

  func updateGroomingActivityById(id: UUID, activity: GroomingActivity) -> GroomingActivity? {
    activityRepository.updateGroomingActivityById(id: id, activity: activity)
  }

  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity? {
    activityRepository.createNewOtherActivity(activity: activity)
  }

  func updateOtherActivityById(id: UUID, activity: OtherActivity) -> OtherActivity? {
    activityRepository.updateOtherActivityById(id: id, activity: activity)
  }

  func getAllActivitiesByDateRange(startDate: Date, endDate: Date) -> [any Activity] {
    activityRepository.getAllActivitiesByDateRange(startDate: startDate, endDate: endDate)
  }

  func deleteActivityById(id: UUID) -> (any Activity)? {
    activityRepository.deleteActivityById(id: id)
  }

  // MARK: Private

  private let activityRepository: ActivityRepository

}
