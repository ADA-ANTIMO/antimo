//
//  ContentView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) private var activities: FetchedResults<Activity>
    
    var body: some View {
       NavigationView {
            List {
                ForEach(activities) { activity in
                    VStack {
                        Text("Item at \(activity.title ?? "Unknown" )")
                        Text("Item at \(activity.type ?? "Unknown")")
                    }
                    .onAppear {
                        if activity.title == "Berenang" {
                            debugPrint(activity)
                        }
//                        debugPrint(activity.activity?.unwrappedTags)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
//       .onAppear {
//           tags.forEach { tag in
//               let activities = tag.activity as? Set<Activity> ?? []
//
//               let arrayOfActivities = activities.sorted {
//                   $0.title! < $1.title!
//               }
//
//               debugPrint(arrayOfActivities.first?.title)
//           }
//       }
    }
    
    private func addItem() {
        withAnimation {
//            let tag1 = Tagging(context: viewContext)
//            tag1.name = "Exercise"
//            tag1.id = UUID()
//
//            let tag2 = Tagging(context: viewContext)
//            tag2.name = "Nutrition"
//            tag2.id = UUID()
//
//            let tag3 = Tagging(context: viewContext)
//            tag3.name = "Medication"
//            tag3.id = UUID()
//
//            let tag4 = Tagging(context: viewContext)
//            tag4.name = "Grooming"
//            tag4.id = UUID()
            
            let newActivity = Activity(context: viewContext)
            newActivity.id = UUID()
            newActivity.title = "Berenang"
            newActivity.type = "Exercise"
//            newActivity.addToTags(tag1)
//            newActivity.addToTags(tag2)
//            newActivity.addToTags(tag3)
//            newActivity.addToTags(tag4)
            
//            let newExerciseActivity = ExerciseActivity(context: viewContext)
//            newExerciseActivity.id = UUID()
//            newExerciseActivity.activity = newActivity
//            newExerciseActivity.duration = 120
//            newExerciseActivity.mood = "Sad"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
