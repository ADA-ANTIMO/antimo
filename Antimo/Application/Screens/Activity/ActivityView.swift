//
//  ActivityView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @EnvironmentObject private var viewModel: ReminderViewModel

  @State private var currentDate = Date.now
  @State private var currentMonth = 0

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(title: "Event") {
        Text("Add Event")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.isEventSheetPresented = true }
      }
    }, children: {
      ScrollView {
        ANCalendar(currentDate: $currentDate, currentMonth: $currentMonth)
        UpcomingEventView()
      }
      .scrollIndicators(.hidden)
      .padding()

    })
    .onAppear {
      if !viewModel.hasNotificationPermission {
        viewModel.requestNotificationPermission()
      }
    }
    .sheet(isPresented: $viewModel.isEventSheetPresented) {
      AddEventSheetView()
    }
  }
}

// MARK: - ActivityView_Previews

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView()
  }
}
