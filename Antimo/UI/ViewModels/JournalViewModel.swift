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

  // MARK: Public

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
  @Published public var isUpdating = false

  public var canSubmit: Bool {
    let activityType = ActivityTypes(rawValue: type)

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

  public func fetchActivityByDateRange(startDate: Date, endDate: Date) {
    activities = activityService.getAllActivitiesByDateRange(startDate: startDate, endDate: endDate)

    print(activities)
  }

  public func fetchAllExerciseActivitiesByDateRange(startDate: Date, endDate: Date) {
    exerciseActivities = activityService.getAllExerciseActivitiesByDateRange(startDate: startDate, endDate: endDate)
  }

  public func deleteActivityById(id: UUID) {
    guard let activity = activityService.deleteActivityById(id: id) else {
      print("Failed deleting activity")
      return
    }

    activities = activities.filter { $0.id != activity.id }
  }

  public func updateSelectedActivity() {
    let date = Utilities.getDate(date: date)
    let time = Utilities.getTime(date: time)
    let newDate = Utilities.createDate(date: date, time: time)

    if let uiImage = imagePicker.uiImage {
      let imageId = UUID().uuidString
      FileManager().saveImage(with: imageId, image: uiImage)
      image = imageId
    }

    switch activityType {
    case .nutrition:
      let nutrition = NutritionActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        isEatenUp: isEatenUp, menu: menu)

      activityService.updateNutritionActivityById(id: id, activity: nutrition)
    case .exercise:
      let exercise = ExerciseActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        duration: Int(duration) ?? 0,
        mood: Mood(rawValue: mood) ?? .low)

      activityService.updateExerciseActivityById(id: id, activity: exercise)
    case .medication:
      let medication = MedicationActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        vet: vet)

      activityService.updateMedicationActivityById(id: id, activity: medication)
    case .grooming:
      let grooming = GroomingActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        salon: salon,
        satisfaction: satisfaction)

      activityService.updateGroomingActivityById(id: id, activity: grooming)
    case .other:
      let other = OtherActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition)

      activityService.updateOtherActivityById(id: id, activity: other)
    }
  }

  public func createNewActivity() {
    let date = Utilities.getDate(date: date)
    let time = Utilities.getTime(date: time)
    let newDate = Utilities.createDate(date: date, time: time)

    if let uiImage = imagePicker.uiImage {
      let imageId = UUID().uuidString
      FileManager().saveImage(with: imageId, image: uiImage)
      image = imageId
    }

    switch activityType {
    case .nutrition:
      let nutrition = NutritionActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        isEatenUp: isEatenUp, menu: menu)

      activityService.createNewNutritionActivity(activity: nutrition)
    case .exercise:
      let exercise = ExerciseActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        duration: Int(duration) ?? 0,
        mood: Mood(rawValue: mood) ?? .low)

      activityService.createNewExerciseActivity(activity: exercise)
    case .medication:
      let medication = MedicationActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        vet: vet)

      activityService.createNewMedicationActivity(activity: medication)
    case .grooming:
      let grooming = GroomingActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition,
        salon: salon,
        satisfaction: satisfaction)

      activityService.createNewGroomingActivity(activity: grooming)
    case .other:
      let other = OtherActivity(
        title: title, image: image, note: note,
        activityType: ActivityTypes(rawValue: type) ?? .nutrition)

      activityService.createNewOtherActivity(activity: other)
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
    isUpdating = false
  }

  public func setState(activity: any Activity) {
    switch activity.activityType {
    case .exercise:
      let exercise = activity as! ExerciseActivity // swiftlint:disable:this force_cast

      mood = exercise.mood.rawValue
      duration = exercise.duration.formatted()
    case .grooming:
      let grooming = activity as! GroomingActivity // swiftlint:disable:this force_cast

      satisfaction = grooming.satisfaction
      salon = grooming.salon
    case .medication:
      print("Empty")
    case .nutrition:
      let nutrition = activity as! NutritionActivity // swiftlint:disable:this force_cast

      isEatenUp = nutrition.isEatenUp
      menu = nutrition.menu
    case .other:
      print("Empty")
    }

    id = activity.id
    image = activity.image
    note = activity.note
    title = activity.title
    type = activity.activityType.rawValue
    createdAt = activity.createdAt

    date = createdAt
    time = createdAt
    imagePicker = ImagePicker()

    if !image.isEmpty {
      imagePicker.uiImage = FileManager().retrieveImage(with: image)
      imagePicker.image = Image(uiImage: imagePicker.uiImage!)
    }

    isUpdating = true
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

  public func submitEditForm() {
    updateSelectedActivity()

    closeActivityForm()
  }

  public func submitForm() {
    createNewActivity()

    closeActivityForm()
  }

  // MARK: Internal

  @Published var activities: [any Activity] = []
  @Published var exerciseActivities: [ExerciseActivity] = []

  var activitiesByDate: OrderedActivity {
    var dictOfActivities = [String: [any Activity]]()
    var keyOfDict = [String]()

    for activity in activities {
      let key = Utilities.formattedDate(from: activity.createdAt, format: "EEEE, d MMM yyyy")

      if var dict = dictOfActivities[key] {
        dict.append(activity)

        dictOfActivities[key] = dict
      } else {
        keyOfDict.append(key)
        dictOfActivities[key] = [activity]
      }
    }

    return OrderedActivity(activities: dictOfActivities, keys: keyOfDict)
  }

  // MARK: Private

  private var activityService = ActivityService(activityRepository: ActivityCoreDataAdapter())

}
