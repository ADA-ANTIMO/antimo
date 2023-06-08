//
//  ActivitySheetView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 06/06/23.
//

import SwiftUI

struct NutritionInputs: View {
    var body: some View {
        Group {
            ANTextField(text: .constant(""), placeholder: "Food name", label: "Menu")
            
            Toggle(isOn: .constant(true)) {
                Text("Food out?")
                    .font(.inputLabel)
            }
        }
    }
}

struct ExerciseInputs: View {
    var body: some View {
        Group {
            ANNumberField(text: .constant(""), placeholder: "Duration in minutes", label: "Duration")
            
            ANMoodSelector(label: "Mood")
        }
    }
}

struct GroomingInputs: View {
    var body: some View {
        Group {
            ANTextField(text: .constant(""), placeholder: "Pet salon name", label: "Pet Salon")
            
            ANMoodSelector(label: "Satisfaction")
        }
    }
}

struct JournalSheetView: View {
    var activityType:ActivityTypes
    var handleClose: () -> Void
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    handleClose()
                }, label: {
                    Text("Cancel")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                })
            }, title: activityType.rawValue)
            .padding(.vertical)
        } children: {
            VStack {
                if activityType == .medication {
                    ANTextField(text: .constant(""), placeholder: "Activity name", label: "Activity Name")
                } else {
                    ANTextField(text: .constant(""), placeholder: "Activity name", label: "Activity Name")
                }
                
                ANDatePicker(date: .constant(Date.now), label: "Date")
                
                ANTimePicker(time: .constant(Date.now), label: "Time")
                
                switch activityType {
                case .nutrition:
                    NutritionInputs()
                case .exercise:
                    ExerciseInputs()
                case .grooming:
                    GroomingInputs()
                default:
                    EmptyView()
                }
                
                ANTextFieldArea(text: .constant(""), label: "Note (optional)", placeholder: "Activity note...")
                
                ANImageUploader(label: "\(activityType.rawValue) photo (optional)")
                
                ANButton("Submit") {
                    handleClose()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

struct ActivitySheetView_Previews: PreviewProvider {
    static var previews: some View {
        JournalSheetView(activityType: .medication) {
            
        }
    }
}
