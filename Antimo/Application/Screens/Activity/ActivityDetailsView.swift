//
//  ActivityDetailsView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 11/06/23.
//

import CoreData
import SwiftUI

struct ActivityDetailsView: View {
  // MARK: Internal
  var selectedDate: Date

  var startDate: Date {
    Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: selectedDate))!
  }

  var endDate: Date {
    Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!
  }

  var body: some View {
    ANBaseContainer(toolbar: {
      ANToolbar(leading: {
        Button(action: {
          activityNavigation.goBack()
        }, label: {
          HStack {
            Image(systemName: "chevron.left")

            Text("Back")
          }
          .font(.toolbar)
          .foregroundColor(Color.anNavigation)
        })
      }, title: "Activity") {
        Button {
          activityNavigation.push(to: .addJournal)
        } label: {
          Text("Add Journal")
            .font(.toolbar)
            .foregroundColor(Color.anNavigation)
        }
      }
    }, children: {
      ScrollView {
        VStack(spacing: 8) {
          ForEach(viewModel.activitiesByDate.keys, id: \.self) { key in
            Section {
              ForEach(viewModel.activitiesByDate.activities[key] ?? [], id: \.self.id) { activity in
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
    })
    .sheet(isPresented: $viewModel.isSheetPresented, onDismiss: {
      viewModel.resetState()
    }) {
      JournalSheetView()
    }
  }

  // MARK: Private

  @EnvironmentObject private var viewModel: JournalViewModel
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
}
