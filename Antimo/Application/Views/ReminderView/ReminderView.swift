//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - ReminderView

struct ReminderView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(sortDescriptors: [NSSortDescriptor(
    key: "reminder.createdAt",
    ascending: false)]) private var routines: FetchedResults<Routine>

  @StateObject var viewModel = ReminderViewModel()
  @StateObject var notificationManager = NotificationsManager()

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(title: "Routine") {
        Text("Add Routine")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.openReminderForm() }
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
            .onTapGesture { viewModel.openReminderForm() }
        }

        Spacer()
      } else {
        ScrollView {
          ForEach(routines) { routine in
            ANReminderCard(
              icon: viewModel.getIcon(routine.reminder?.type ?? ""),
              title: routine.reminder?.title ?? "",
              time: viewModel.getRenderedHourAndMinutes(routine.getWeekdays.first?.time ?? Date()),
              frequency: viewModel.getRenderedFrequency(viewModel.convertWeekDaysObjIntoInt(routine.getWeekdays)),
              isOn: routine.reminder?.isActive ?? false,
              onToggle: { newValue in
                viewModel.toggleActivation(
                  reminder: routine.reminder!,
                  viewContext: viewContext,
                  notificationManager: notificationManager,
                  newValue: newValue)
              })
          }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .padding(.bottom)
      }
    })
    .onAppear { notificationManager.request() }
    .sheet(isPresented: $viewModel.isReminderFormPresented) {
      ReminderFormView(
        viewModel: viewModel,
        onSubmit: {
          viewModel.addReminder(viewContext: viewContext, notificationManager: notificationManager)
        })
    }
  }
}

// MARK: - ReminderView_Previews

struct ReminderView_Previews: PreviewProvider {
  static var previews: some View {
    ReminderView()
  }
}
