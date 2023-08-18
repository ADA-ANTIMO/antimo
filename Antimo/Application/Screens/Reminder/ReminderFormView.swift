//
//  ReminderFormView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

// MARK: - ReminderFormView

struct ReminderFormView: View {
  @EnvironmentObject private var viewModel: ReminderViewModel

  var body: some View {
    VStack {
      ANToolbar(leading: {
        Text("Cancel")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.closeReminderForm() }
      }, title: "Add Reminder") {
        Text("Save")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation.opacity(viewModel.disabledAddRoutineSubmission ? 0.1 : 1))
          .onTapGesture {
            viewModel.createNewRoutine()
          }
          .disabled(viewModel.disabledAddRoutineSubmission)
      }

      ScrollView {
        ANActivitySelector(selected: $viewModel.selectedActivityType)
        ANTextField(text: $viewModel.title, placeholder: "Add reminder title...", label: "Title")

        ANTextFieldArea(text: $viewModel.desc, label: "Description", placeholder: "Add description...")
          .frame(height: 200)

        ANTimePicker(time: $viewModel.time, label: "Time")

        HStack {
          Text("Repeat")

          Spacer()

          Group {
            if viewModel.selectedDays().isEmpty {
              Text("Choose Frequency")
            } else {
              Text(viewModel.getRenderedFrequency(viewModel.selectedDays().map { $0.value }))
            }
          }
          .onTapGesture { viewModel.openDaysSelectorForm() }
        }
      }
      .scrollIndicators(.hidden)
      .padding()

      Spacer()
    }
    .padding(.vertical)
    .sheet(isPresented: $viewModel.isDaysSelectorPresented) { DaysSelectorView() }
    .onDisappear { viewModel.resetForm() }
  }
}

// MARK: - ReminderFormView_Previews

struct ReminderFormView_Previews: PreviewProvider {
  static var previews: some View {
    ReminderFormView()
  }
}
