//
//  ActivityRepository.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation

protocol ActivityRepository {
  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity?
  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity?
  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity?
  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity?
  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity?
}
