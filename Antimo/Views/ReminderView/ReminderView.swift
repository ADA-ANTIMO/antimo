//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]) private var reminders: FetchedResults<Reminder>
    
    @StateObject var vm = ReminderViewModel()
    @StateObject var notificationManager = NotificationsManager()
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Reminder") {
                Text("Add Reminder")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.openReminderForm() }
            }
        }, children: {
            
            ScrollView {
                ForEach(reminders) { reminder in
                    ANReminderCard(icon: vm.getIcon(reminder.type ?? ""),
                                   title: reminder.title ?? "",
                                   time: vm.getRenderedHourAndMinutes(reminder.routine?.getWeekdays.first?.time ?? Date()),
                                   frequency: vm.getRenderedFrequency(
                                    vm.convertWeekDaysObjIntoInt(reminder.routine?.getWeekdays ?? [])),
                                   isOn: reminder.isActive,
                                   onToggle: { newValue in
                        vm.toggleActivation(
                            reminder: reminder,
                            viewContext: viewContext,
                            notificationManager: notificationManager,
                            newValue: newValue
                        )
                    }
                    )
                }
            }
            .padding(.horizontal)
        })
        .onAppear { notificationManager.request() }
        .sheet(isPresented: $vm.isReminderFormPresented) {
            ReminderFormView(vm: vm, onSubmit: {
                vm.addReminder(viewContext: viewContext, notificationManager: notificationManager)
            })
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
