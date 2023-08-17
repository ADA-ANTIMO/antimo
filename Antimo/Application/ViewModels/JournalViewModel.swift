//
//  JournalViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import CoreData
import SwiftUI

@MainActor
class JournalViewModel: ObservableObject {
  @Published public var id: UUID = .init()
  @Published public var image = ""
  @Published public var note = ""
  @Published public var title = ""
  @Published public var type = ""
  @Published public var vet = ""
  @Published public var mood = ""
  @Published public var duration = ""
  @Published public var isEatenUp = false
  @Published public var menu = ""
  @Published public var satisfaction = ""
  @Published public var salon = ""
  @Published public var createdAt: Date = .init()

  @Published public var date: Date = .init()
  @Published public var time: Date = .init()
  @Published public var imagePicker = ImagePicker()
  @Published public var isSheetPresented = false
  @Published public var activityType: ActivityTypes = .nutrition
  @Published public var selectedActivity: Activity?

  public var canSubmit: Bool {
    let activityType = ActivityTypes.getByString(type: type)

    switch activityType {
    case .nutrition:
      return !title.isEmpty && !menu.isEmpty
    case .medication:
      return !title.isEmpty && (!vet.isEmpty || type == "Vet")
    case .exercise:
      return !title.isEmpty && !duration.isEmpty && !mood.isEmpty
    case .grooming:
      return !title.isEmpty && !salon.isEmpty && !satisfaction.isEmpty
    default:
      return !title.isEmpty && !note.isEmpty
    }
  }

  public func resetState() {
    id = UUID()
    image = ""
    note = ""
    title = ""
    type = ""
    mood = ""
    duration = ""
    isEatenUp = false
    menu = ""
    satisfaction = ""
    salon = ""
    createdAt = Date()
    date = Date()
    time = Date()
    imagePicker = ImagePicker()
  }

  public func setState(activity: Activity) {
    id = activity.id ?? UUID()
    image = activity.imagePath
    note = activity.note ?? ""
    title = activity.title ?? ""
    type = activity.type ?? ""
    mood = activity.exercise?.mood ?? ""
    duration = activity.exercise?.duration.formatted() ?? ""
    isEatenUp = activity.nutrition?.isEatenUp ?? false
    menu = activity.nutrition?.menu ?? ""
    satisfaction = activity.grooming?.satisfaction ?? ""
    salon = activity.grooming?.salon ?? ""
    createdAt = activity.createdAt ?? Date()

    date = createdAt
    time = createdAt
    imagePicker = ImagePicker()

    if !image.isEmpty {
      imagePicker.uiImage = FileManager().retrieveImage(with: image)
      imagePicker.image = Image(uiImage: imagePicker.uiImage!)
    }
  }

  public func openActivityForm(selectedActivityType: ActivityTypes) {
    activityType = selectedActivityType
    type = activityType.rawValue
    isSheetPresented = true
  }

  public func closeActivityForm() {
    resetState()
    isSheetPresented = false
  }

  public func submitEditForm(context: NSManagedObjectContext) {
    let date = Utilities.getDate(date: date)
    let time = Utilities.getTime(date: time)
    let newDate = Utilities.createDate(date: date, time: time)

    if let uiImage = imagePicker.uiImage {
      let imageId = UUID().uuidString
      FileManager().saveImage(with: imageId, image: uiImage)
      image = imageId
    }

    guard let selectedActivity else {
      return
    }

    selectedActivity.id = id
    selectedActivity.title = title
    selectedActivity.type = type
    selectedActivity.note = note
    selectedActivity.image = image
    selectedActivity.createdAt = newDate

    switch activityType {
    case .nutrition:
      selectedActivity.nutrition?.isEatenUp = isEatenUp
      selectedActivity.nutrition?.menu = menu

    case .exercise:
      selectedActivity.exercise?.mood = mood
      selectedActivity.exercise?.duration = Int32(duration) ?? 0

    case .medication:
      selectedActivity.medication?.vet = vet

    case .grooming:
      selectedActivity.grooming?.salon = salon
      selectedActivity.grooming?.satisfaction = satisfaction

    case .other:
      print("Empty")
    }

    do {
      try context.save()

      closeActivityForm()
    } catch {
      let nsError = error as NSError
      debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }

  public func submitForm(context: NSManagedObjectContext) {
    let date = Utilities.getDate(date: date)
    let time = Utilities.getTime(date: time)
    let newDate = Utilities.createDate(date: date, time: time)

    if let uiImage = imagePicker.uiImage {
      let imageId = UUID().uuidString
      FileManager().saveImage(with: imageId, image: uiImage)
      image = imageId
    }

    let newActivity = Activity(context: context)

    newActivity.id = id
    newActivity.title = title
    newActivity.type = type
    newActivity.note = note
    newActivity.image = image
    newActivity.createdAt = newDate

    switch activityType {
    case .nutrition:
      let newNutrition = NutritionActivity(context: context)
      newNutrition.id = UUID()
      newNutrition.isEatenUp = isEatenUp
      newNutrition.menu = menu
      newNutrition.activity = newActivity

    case .exercise:
      let newExercise = ExerciseActivity(context: context)
      newExercise.id = UUID()
      newExercise.mood = mood
      newExercise.duration = Int32(duration) ?? 0
      newExercise.activity = newActivity

    case .medication:
      let newMedication = MedicationActivity(context: context)
      newMedication.id = UUID()
      newMedication.vet = vet
      newMedication.activity = newActivity

    case .grooming:
      let newGrooming = GroomingActivity(context: context)
      newGrooming.id = UUID()
      newGrooming.salon = salon
      newGrooming.satisfaction = satisfaction
      newGrooming.activity = newActivity

    case .other:
      let newOther = OtherActivity(context: context)
      newOther.id = UUID()
      newOther.activity = newActivity
    }

    do {
      try context.save()

      closeActivityForm()
    } catch {
      let nsError = error as NSError
      debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
}
