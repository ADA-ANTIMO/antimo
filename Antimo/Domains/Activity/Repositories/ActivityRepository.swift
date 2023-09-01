//
//  ActivityRepository.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

protocol ActivityRepository {
  func createNewNutritionActivity(activity: NutritionActivity) -> NutritionActivity?
  func updateNutritionActivityById(id: UUID, activity: NutritionActivity) -> NutritionActivity?

  func createNewExerciseActivity(activity: ExerciseActivity) -> ExerciseActivity?
  func getAllExerciseActivitiesByDateRange(startDate: Date, endDate: Date) -> [ExerciseActivity]
  func updateExerciseActivityById(id: UUID, activity: ExerciseActivity) -> ExerciseActivity?

  func createNewMedicationActivity(activity: MedicationActivity) -> MedicationActivity?
  func updateMedicationActivityById(id: UUID, activity: MedicationActivity) -> MedicationActivity?

  func createNewGroomingActivity(activity: GroomingActivity) -> GroomingActivity?
  func updateGroomingActivityById(id: UUID, activity: GroomingActivity) -> GroomingActivity?

  func createNewOtherActivity(activity: OtherActivity) -> OtherActivity?
  func updateOtherActivityById(id: UUID, activity: OtherActivity) -> OtherActivity?

  func getAllActivitiesByDateRange(startDate: Date, endDate: Date) -> [any Activity]
  func deleteActivityById(id: UUID) -> (any Activity)?
}
