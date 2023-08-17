//
//  AllEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

// MARK: - AllEventView

struct AllEventView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "reminder.createdAt", ascending: false)])
  private var events: FetchedResults<Event>

  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @StateObject var viewModel = ActivityViewModel()
  @StateObject var notificationManager = NotificationsManager()

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
        ForEach(events.byDate.keys, id: \.self) { key in
          Section {
            ForEach(events.byDate.events[key] ?? [], id: \.self) { event in
              ANEventCard(
                icon: viewModel.getIcon(event.reminder?.type ?? ""),
                title: event.reminder?.title ?? "",
                desc: event.reminder?.desc ?? "",
                time: viewModel.getRenderedHourAndMinutes(event.triggerDate ?? Date()))
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
      AddEventSheetView(
        viewModel: viewModel,
        onSubmit: {
          viewModel.addEvent(viewContext: viewContext, notificationManager: notificationManager)
        })
    }
  }
}

// MARK: - AllEventView_Previews

struct AllEventView_Previews: PreviewProvider {
  static var previews: some View {
    AllEventView()
  }
}
