//
//  JournalViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import SwiftUI
import CoreData

@MainActor
class JournalViewModel: ObservableObject {
    @Published public var id: UUID = UUID()
    @Published public var image: String = ""
    @Published public var note: String = ""
    @Published public var title: String = ""
    @Published public var type: String = ""
    @Published public var vet: String = ""
    @Published public var mood: String = ""
    @Published public var duration: String = ""
    @Published public var isEatenUp: Bool = false
    @Published public var menu: String = ""
    @Published public var satisfaction: String = ""
    @Published public var salon: String = ""
    @Published public var createdAt: Date = Date()
    
    @Published public var date: Date = Date()
    @Published public var time: Date = Date()
    @Published public var imagePicker = ImagePicker()
    @Published public var isSheetPresented = false
    @Published public var activityType: ActivityTypes = .nutrition
    @Published public var selectedActivity: Activity? = nil
    
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
    
    public func openActivityForm(selectedActivityType:ActivityTypes) {
        activityType = selectedActivityType
        type = activityType.rawValue
        isSheetPresented = true
    }
    
    public func closeActivityForm() {
        self.resetState()
        isSheetPresented = false
    }
    
    public func submitEditForm(context: NSManagedObjectContext) {
        let date = Utilities.getDate(date: self.date)
        let time = Utilities.getTime(date: self.time)
        let newDate = Utilities.createDate(date: date, time: time)
        
        if let uiImage = self.imagePicker.uiImage {
            let imageId = UUID().uuidString
            FileManager().saveImage(with: imageId, image: uiImage)
            self.image = imageId
        }
        
        guard let selectedActivity = selectedActivity else {
            return
        }
        
        selectedActivity.id = self.id
        selectedActivity.title = self.title
        selectedActivity.type = self.type
        selectedActivity.note = self.note
        selectedActivity.image = self.image
        selectedActivity.createdAt = newDate
        
        switch self.activityType {
        case .nutrition:
            selectedActivity.nutrition?.isEatenUp = self.isEatenUp
            selectedActivity.nutrition?.menu = self.menu
           
        case .exercise:
            selectedActivity.exercise?.mood = self.mood
            selectedActivity.exercise?.duration = Int32(self.duration) ?? 0
            
        case .medication:
            selectedActivity.medication?.vet = self.vet
                        
        case .grooming:
            selectedActivity.grooming?.salon = self.salon
            selectedActivity.grooming?.satisfaction = self.satisfaction
            
        case .other:
            print("Empty")
        }
        
        do {
            try context.save()
            
            self.closeActivityForm()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    public func submitForm(context: NSManagedObjectContext) {
        let date = Utilities.getDate(date: self.date)
        let time = Utilities.getTime(date: self.time)
        let newDate = Utilities.createDate(date: date, time: time)
        
        if let uiImage = self.imagePicker.uiImage {
            let imageId = UUID().uuidString
            FileManager().saveImage(with: imageId, image: uiImage)
            self.image = imageId
        }
        
        let newActivity = Activity(context: context)
        
        newActivity.id = self.id
        newActivity.title = self.title
        newActivity.type = self.type
        newActivity.note = self.note
        newActivity.image = self.image
        newActivity.createdAt = newDate
        
        switch self.activityType {
        case .nutrition:
            let newNutrition = NutritionActivity(context: context)
            newNutrition.id = UUID()
            newNutrition.isEatenUp = self.isEatenUp
            newNutrition.menu = self.menu
            newNutrition.activity = newActivity
            
        case .exercise:
            let newExercise = ExerciseActivity(context: context)
            newExercise.id = UUID()
            newExercise.mood = self.mood
            newExercise.duration = Int32(self.duration) ?? 0
            newExercise.activity = newActivity
            
        case .medication:
            let newMedication = MedicationActivity(context: context)
            newMedication.id = UUID()
            newMedication.vet = self.vet
            newMedication.activity = newActivity
            
        case .grooming:
            let newGrooming = GroomingActivity(context: context)
            newGrooming.id = UUID()
            newGrooming.salon = self.salon
            newGrooming.satisfaction = self.satisfaction
            newGrooming.activity = newActivity
            
        case .other:
            let newOther = OtherActivity(context: context)
            newOther.id = UUID()
            newOther.activity = newActivity
        }
        
        do {
            try context.save()
            
            self.closeActivityForm()
        } catch {
            let nsError = error as NSError
            debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
