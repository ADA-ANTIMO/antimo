//
//  UpcomingEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct UpcomingEventView: View {
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @EnvironmentObject private var viewModel: ReminderViewModel

  var body: some View {
    VStack(spacing: 10) {
      HStack {
        Text("Upcoming Events").font(.sectionHeading)

        Spacer()

        if viewModel.events.isEmpty {
          EmptyView()
        } else {
          Text("Show All")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation)
            .onTapGesture {
              activityNavigation.push(to: .allEvents)
            }
        }
      }
      .padding(.top)

      if viewModel.events.isEmpty {
        HStack {
          Spacer()
          Text("There are no upcoming events yet")
            .font(.placeholder)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)
          Spacer()
        }
      } else {
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
                .font(.date).opacity(0.5)

              Spacer()
            }
          }
        }
      }
    }
  }
}
