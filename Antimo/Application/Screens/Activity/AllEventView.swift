//
//  AllEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

// MARK: - AllEventView

struct AllEventView: View {
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @EnvironmentObject private var viewModel: ReminderViewModel

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(leading: {
        Text("Back")
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
          .onTapGesture { activityNavigation.goBack() }
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
            ForEach(viewModel.eventsByDate.events[key] ?? []) { event in
              ANEventCard(
                icon: viewModel.getIcon(event.activityType.rawValue),
                title: event.title,
                desc: event.description,
                time: viewModel.getRenderedHourAndMinutes(event.triggerDate)
              )
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
}

// MARK: - AllEventView_Previews

struct AllEventView_Previews: PreviewProvider {
  static var previews: some View {
    AllEventView()
  }
}
