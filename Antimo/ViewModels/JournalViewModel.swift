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
    @Published public var selectedActivity: ActivityTypes = .nutrition
    
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
    
    public func openActivityForm(activity:ActivityTypes) {
        selectedActivity = activity
        type = activity.rawValue
        isSheetPresented = true
    }
    
    public func closeActivityForm() {
        self.resetState()
        isSheetPresented = false
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
        
        switch self.selectedActivity {
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
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
