//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - ReminderView

struct ReminderView: View {
  @EnvironmentObject private var viewModel: ReminderViewModel

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(title: "Routine") {
        Text("Add Routine")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.openReminderForm() }
      }
    }, children: {
      if viewModel.routines.isEmpty {
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
          ForEach(viewModel.routines) { routine in
            ANReminderCard(
              icon: viewModel.getIcon(routine.activityType.rawValue),
              title: routine.title,
              time: viewModel.getRenderedHourAndMinutes(routine.weekdays.first?.time ?? Date()),
              frequency: viewModel.getRenderedFrequency(viewModel.convertWeekDaysObjIntoInt(routine.weekdays)),
              isOn: routine.isActive,
              onToggle: { newStatus in
                viewModel.updateRoutineIsActiveStatus(id: routine.id, newStatus: newStatus)
              })
          }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal)
        .padding(.bottom)
      }
    })
    .onAppear {
      viewModel.requestNotificationPermission()
    }
    .sheet(isPresented: $viewModel.isReminderFormPresented) {
      ReminderFormView()
    }
  }
}

// MARK: - ReminderView_Previews

struct ReminderView_Previews: PreviewProvider {
  static var previews: some View {
    ReminderView()
  }
}
