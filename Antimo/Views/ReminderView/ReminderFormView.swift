//
//  ReminderFormView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct ReminderFormView: View {
    @ObservedObject var vm: ReminderViewModel
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            ANToolbar(leading: {
                Text("Cancel")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.closeReminderForm() }
            }, title: "Add Reminder") {
                Text("Save")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture {
                        onSubmit()
                    }
            }
            
            VStack {
                ANActivitySelector(selected: $vm.selectedActivityType)
                ANTextField(text: $vm.title, placeholder: "Add reminder title...", label: "Title")
                
                ANTextFieldArea(text: $vm.desc, label: "Description", placeholder: "Add description...")
                    .frame(height: 200)
                
                ANTimePicker(time: $vm.time, label: "Time")
                
                HStack {
                    Text("Repeat")
                    Spacer()
                    Group {
                        if vm.selectedDays().isEmpty {
                            Text("Choose Frequency")
                        } else {
                            Text(vm.getRenderedFrequency(vm.selectedDays().map{ $0.value }))
                        }
                    }
                    
                        .onTapGesture { vm.openDaysSelectorForm() }
                }
            }
            .padding()
            
            Spacer()
        }
        .padding(.vertical)
        .sheet(isPresented: $vm.isDaysSelectorPresented) { DaysSelectorView(vm: vm) }
        .onDisappear { vm.resetForm() }
    }
}




struct ReminderFormView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderFormView(vm: ReminderViewModel(), onSubmit:  {
            
        })
    }
}
