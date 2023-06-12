//
//  AddEventSheetView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct AddEventSheetView: View {
    @ObservedObject var vm: ActivityViewModel
    var onSubmit: () -> Void
    
    var body: some View {
        VStack {
            ANToolbar(leading: {
                Text("Cancel")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.closeEventSheet()}
            }, title: "Add Event") {
                Text("Save")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation.opacity(vm.disableAddEventSubmission ? 0.1 : 1))
                    .onTapGesture { onSubmit() }
                    .disabled(vm.disableAddEventSubmission)
            }
            
            ScrollView {
                ANActivitySelector(selected: $vm.selectedActivityType)
                ANTextField(text: $vm.eventTitle, placeholder: "Add Event Title", label: "Title")
                ANTextFieldArea(text: $vm.eventDesc, label: "Description", placeholder: "Add Event Description")
                    .frame(height: 200)
                
                ANDatePicker(date: $vm.eventDate, label: "Date", endDate: false)
                
                ANTimePicker(time: $vm.eventTime, label: "Time")
            }
            .scrollIndicators(.hidden)
            .padding()
            
            Spacer()
        }
        .padding(.vertical)
        .onDisappear { vm.resetEventSheetForm() }
    }
}

struct AddEventSheetView_Previews: PreviewProvider {
    static var previews: some View {
        AddEventSheetView(vm: ActivityViewModel(), onSubmit: {})
    }
}
