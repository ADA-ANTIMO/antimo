//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "reminder.createdAt", ascending: false)]) private var routines: FetchedResults<Routine>
    
    @StateObject var vm = ReminderViewModel()
    @StateObject var notificationManager = NotificationsManager()
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Routine") {
                Text("Add Routine")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.openReminderForm() }
            }
        }, children: {
            if routines.isEmpty {
                Spacer()

                VStack(spacing: 10) {
                    Text("You don't have any reminders yet, Let's add some now")
                        .font(.placeholder)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.gray)
                    
                    Text("Add Routine")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture { vm.openReminderForm() }
                }

                Spacer()
            } else {
                ScrollView {
                    ForEach(routines) { routine in
                        ANReminderCard(
                            icon: vm.getIcon(routine.reminder?.type ?? ""),
                            title: routine.reminder?.title ?? "",
                            time: vm.getRenderedHourAndMinutes(routine.getWeekdays.first?.time ?? Date()),
                            frequency: vm.getRenderedFrequency(vm.convertWeekDaysObjIntoInt(routine.getWeekdays)),
                            isOn: routine.reminder?.isActive ?? false,
                            onToggle: { newValue in
                                vm.toggleActivation(
                                    reminder: routine.reminder!,
                                    viewContext: viewContext,
                                    notificationManager: notificationManager,
                                    newValue: newValue
                                )
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
        })
        .onAppear { notificationManager.request() }
        .sheet(isPresented: $vm.isReminderFormPresented) {
            ReminderFormView(
                vm: vm,
                onSubmit: {
                    vm.addReminder(viewContext: viewContext, notificationManager: notificationManager)
                }
            )
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
