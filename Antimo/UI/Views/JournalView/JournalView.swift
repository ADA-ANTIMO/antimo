//
//  DashboardView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import CoreData
import SwiftUI

struct JournalView: View {

  // MARK: Internal

  var startDate: Date {
    let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? Date.now
    let startDate = Calendar.current.startOfDay(for: lastWeek)

    return startDate
  }

  var endDate: Date {
    Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now) ?? Date.now
  }

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(title: "Journal") {
        Button {
          journalNavigation.push(to: .addJournal)
        } label: {
          Text("Add Journal")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation)
        }
      }
    }, children: {
      if viewModel.activities.isEmpty {
        Spacer()

        VStack {
          Text("There are no journals\n available yet, let's make your\n journal soon")
            .font(.placeholder)
            .multilineTextAlignment(.center)
            .foregroundColor(Color.gray)

          ANButton("+") {
            journalNavigation.push(to: .addJournal)
          }
        }

        Spacer()
      } else {
        ScrollView {
          VStack(spacing: 8) {
            ForEach(viewModel.activitiesByDate.keys, id: \.self) { key in
              Section {
                ForEach(viewModel.activitiesByDate.activities[key] ?? [], id: \.id) { activity in
                  let editAction = Action(type: .edit) {
                    viewModel.setState(activity: activity)
                    viewModel.openActivityForm(selectedActivityType: activity.activityType)
                  }

                  let deleteAction = Action(type: .delete) {
                    viewModel.deleteActivityById(id: activity.id)
                  }

                  ANActivityDetails(activity: activity, actions: [editAction, deleteAction])
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
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.horizontal, 16)
          .padding(.vertical, 8)
        }
        .frame(maxWidth: .infinity)
      }
    })
    .sheet(isPresented: $viewModel.isSheetPresented, onDismiss: {
      viewModel.resetState()
    }) {
      JournalSheetView()
    }
    .onAppear {
      viewModel.fetchActivityByDateRange(startDate: startDate, endDate: endDate)
    }
  }

  // MARK: Private

  @EnvironmentObject private var viewModel: JournalViewModel
  @EnvironmentObject private var journalNavigation: JournalNavigationManager
}
