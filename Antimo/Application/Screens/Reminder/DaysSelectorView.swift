//
//  DaysSelectorView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

// MARK: - DaysSelectorView

struct DaysSelectorView: View {
  @EnvironmentObject private var viewModel: ReminderViewModel

  var body: some View {
    VStack {
      ANToolbar(leading: {
        Text("Back")
          .font(.toolbar)
          .foregroundColor(.anNavigation)
          .onTapGesture { viewModel.closeDaysSelectorForm() }
      }, title: "Repeat")
        .padding(.vertical)

      List(viewModel.reminderDays) { day in
        Button(action: { viewModel.toggleSelection(for: day) }) {
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

// MARK: - DaysSelectorView_Previews

struct DaysSelectorView_Previews: PreviewProvider {
  static var previews: some View {
    DaysSelectorView()
  }
}
