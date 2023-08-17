//
//  ActivityService.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation

class ActivityService {
  private let activityRepository: ActivityRepository

  init(activityRepository: ActivityRepository) {
    self.activityRepository = activityRepository
  }

  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity? {
    activityRepository.createNewNutritionActivity(activity: activity)
  }

  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity? {
    activityRepository.createNewExerciseActivity(activity: activity)
  }

  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity? {
    activityRepository.createNewMedicationActivity(activity: activity)
  }

  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity? {
    activityRepository.createNewGroomingActivity(activity: activity)
  }

  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity? {
    activityRepository.createNewOtherActivity(activity: activity)
  }
}
