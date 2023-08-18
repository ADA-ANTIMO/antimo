//
//  DashboardAllEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 12/06/23.
//

import SwiftUI

// MARK: - DashboardAllEventView

struct DashboardAllEventView: View {

  // MARK: Internal

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(leading: {
        Text("Back")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { dashboardNavigation.goBack() }
      }, title: "Add Reminder") {
        Text("Add Event")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { viewModel.isEventSheetPresented = true }
      }
    }, children: {
      ScrollView {
        ForEach(viewModel.eventsByDate.keys, id: \.self) { key in
          Section {
            ForEach(viewModel.eventsByDate.events[key] ?? [], id: \.id) { event in
              ANEventCard(
                icon: viewModel.getIcon(event.activityType.rawValue),
                title: event.title,
                desc: event.description,
                time: viewModel.getRenderedHourAndMinutes(event.triggerDate))
            }
          } header: {
            HStack {
              Text(key)
                .font(.date)

              Spacer()
            }
          }
        }
      }
      .scrollIndicators(.hidden)
      .padding(.horizontal)
    })
    .sheet(isPresented: $viewModel.isEventSheetPresented) {
      AddEventSheetView()
    }
  }

  // MARK: Private

  @EnvironmentObject private var dashboardNavigation: DashboardNavigationManager
  @EnvironmentObject private var viewModel: ReminderViewModel

}

// MARK: - DashboardAllEventView_Previews

struct DashboardAllEventView_Previews: PreviewProvider {
  static var previews: some View {
    DashboardAllEventView()
  }
}
