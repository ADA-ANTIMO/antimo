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
    @FocusState private var keyboardVisible: Bool
    
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
            }, title: vm.activityType.rawValue)
            .padding(.vertical)
        } children: {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 12) {
                        if vm.activityType == .medication {
                            ANActivityPicker(selected: $vm.title, label: "Activity:")
                        } else {
                            ANTextField(text: $vm.title, placeholder: "Activity name", label: "Activity Name")
                        }
                        
                        ANDatePicker(date: $vm.date, label: "Date")
                        
                        ANTimePicker(time: $vm.time, label: "Time")
                        
                        switch vm.activityType {
                        case .nutrition:
                            NutritionInputs()
                        case .medication:
                            if vm.title == "Vet" {
                                ANTextField(text: $vm.vet, placeholder: "Vet name", label: "Vet")
                            }
                        case .exercise:
                            ExerciseInputs()
                        case .grooming:
                            GroomingInputs()
                        default:
                            EmptyView()
                        }
                        
                        ANTextFieldArea(text: $vm.note, label: "Note (optional)", placeholder: "Activity note...")
                            .id("note")
                            .focused($keyboardVisible)
                        
                        ANImageUploader(imagePicker: vm.imagePicker, label: "\(vm.activityType.rawValue) photo (optional)")
                        
                        ANButton("Submit") {
                            if vm.selectedActivity != nil {
                                vm.submitEditForm(context: viewContext)
                            } else {
                                vm.submitForm(context: viewContext)
                            }
                        }
                        .buttonStyle(.fill)
                        .grayscale(vm.canSubmit ? 0 : 0.75)
                        .opacity(vm.canSubmit ? 1 : 0.5)
                        .disabled(!vm.canSubmit)
                    }
                    .padding(.horizontal, 16)
                }
                .onChange(of: keyboardVisible) { _ in
                    if keyboardVisible {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 1)) {
                                proxy.scrollTo("note")
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if let selectedActivity = vm.selectedActivity {
                vm.setState(activity: selectedActivity)
            }
        }
    }
}
