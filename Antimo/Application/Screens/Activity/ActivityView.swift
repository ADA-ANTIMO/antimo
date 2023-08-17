//
//  ActivityView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

// MARK: - ActivityView

struct ActivityView: View {
  @Environment(\.managedObjectContext) private var viewContext

  @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "triggerDate", ascending: true)])
  private var events: FetchedResults<Event>

  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
  @StateObject var viewModel = ActivityViewModel()
  @StateObject var notificationManager = NotificationsManager()
  @State var currentDate = Date.now
  @State var currentMonth = 0

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
        UpcomingEventView(viewModel: viewModel, events: events, onShowAll: { activityNavigation.push(to: .allEvents) })
      }
      .scrollIndicators(.hidden)
      .padding()

    })
    .onAppear {
      if !notificationManager.hasPermission {
        print(notificationManager.hasPermission)
        notificationManager.request()
      }
    }
    .sheet(isPresented: $viewModel.isEventSheetPresented) {
      AddEventSheetView(
        viewModel: viewModel,
        onSubmit: {
          viewModel.addEvent(viewContext: viewContext, notificationManager: notificationManager)
        })
    }
  }
}

// MARK: - ActivityView_Previews

struct ActivityView_Previews: PreviewProvider {
  static var previews: some View {
    ActivityView()
  }
}
