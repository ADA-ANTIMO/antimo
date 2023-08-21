//
//  DaysSelectorView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct DaysSelectorView: View {
    @ObservedObject var vm: ReminderViewModel
    
    var body: some View {
        VStack {
            ANToolbar(leading: {
                Text("Back")
                    .font(.toolbar)
                    .foregroundColor(.anNavigation)
                    .onTapGesture { vm.closeDaysSelectorForm() }
            }, title: "Repeat")
            .padding(.vertical)
            
            List(vm.reminderDays) { day in
                Button(action: { vm.toggleSelection(for: day) }) {
                    HStack {
                        Text(day.label)
                        Spacer()
                        if day.isSelected {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.anPrimary)
                        }
                    }
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
    }
}

struct DaysSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        DaysSelectorView(vm: ReminderViewModel())
    }
}
