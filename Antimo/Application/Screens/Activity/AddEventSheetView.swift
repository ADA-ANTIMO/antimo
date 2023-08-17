//
//  AddEventSheetView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

// MARK: - AddEventSheetView

struct AddEventSheetView: View {
  @EnvironmentObject var viewModel: ReminderViewModel

  var body: some View {
    VStack {
      ANToolbar(leading: {
        Text("Cancel")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.closeEventSheet() }
      }, title: "Add Event") {
        Text("Save")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation.opacity(viewModel.disableAddEventSubmission ? 0.1 : 1))
          .onTapGesture {
            viewModel.createNewEvent()
          }
          .disabled(viewModel.disableAddEventSubmission)
      }

      ScrollView {
        ANActivitySelector(selected: $viewModel.eventActivityType)
        ANTextField(text: $viewModel.eventTitle, placeholder: "Add Event Title", label: "Title")
        ANTextFieldArea(text: $viewModel.eventDesc, label: "Description", placeholder: "Add Event Description")
          .frame(height: 200)

        ANDatePicker(date: $viewModel.eventDate, label: "Date", endDate: false)

        ANTimePicker(time: $viewModel.eventTime, label: "Time")
      }
      .scrollIndicators(.hidden)
      .padding()

      Spacer()
    }
    .padding(.vertical)
    .onDisappear { viewModel.resetEventSheetForm() }
  }
}

// MARK: - AddEventSheetView_Previews

struct AddEventSheetView_Previews: PreviewProvider {
  static var previews: some View {
    AddEventSheetView()
  }
}
