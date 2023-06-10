//
//  ActivitySheetView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 06/06/23.
//

import SwiftUI

struct NutritionInputs: View {
    @EnvironmentObject var vm: JournalViewModel
    
    var body: some View {
        Group {
            ANTextField(text: $vm.menu, placeholder: "Food name", label: "Menu")
            
            Toggle(isOn: $vm.isEatenUp) {
                Text("Eaten Up?")
                    .font(.inputLabel)
            }
        }
    }
}

struct ExerciseInputs: View {
    @EnvironmentObject var vm: JournalViewModel
    
    var body: some View {
        Group {
            ANNumberField(text: $vm.duration, placeholder: "Duration in minutes", label: "Duration", suffix: "Minutes")
            
            ANMoodSelector(selectedMood: $vm.mood, label: "Mood")
        }
    }
}

struct GroomingInputs: View {
    @EnvironmentObject var vm: JournalViewModel
    
    var body: some View {
        Group {
            ANTextField(text: $vm.salon, placeholder: "Pet salon name", label: "Pet Salon")
            
            ANMoodSelector(selectedMood: $vm.mood, label: "Satisfaction")
        }
    }
}

struct JournalSheetView: View {
    @EnvironmentObject var vm: JournalViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    vm.closeActivityForm()
                }, label: {
                    Text("Cancel")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                })
            }, title: vm.selectedActivity.rawValue)
            .padding(.vertical)
        } children: {
            VStack(spacing: 12) {
                if vm.selectedActivity == .medication {
                    ANActivityPicker(selected: $vm.title, label: "Activity:")
                } else {
                    ANTextField(text: $vm.title, placeholder: "Activity name", label: "Activity Name")
                }
                
                ANDatePicker(date: $vm.date, label: "Date")
                
                ANTimePicker(time: $vm.time, label: "Time")
                
                switch vm.selectedActivity {
                case .nutrition:
                    NutritionInputs()
                case .medication:
                    ANTextField(text: $vm.vet, placeholder: "Vet name", label: "Vet")
                case .exercise:
                    ExerciseInputs()
                case .grooming:
                    GroomingInputs()
                default:
                    EmptyView()
                }
                
                ANTextFieldArea(text: $vm.note, label: "Note (optional)", placeholder: "Activity note...")
                
                ANImageUploader(imagePicker: vm.imagePicker, label: "\(vm.selectedActivity.rawValue) photo (optional)")
                
                ANButton("Submit") {
                    let date = Utilities.getDate(date: vm.date)
                    let time = Utilities.getTime(date: vm.time)
                    let newDate = Utilities.createDate(date: date, time: time)
                    
                    print(newDate)
                    
                    vm.submitForm(context: viewContext)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
