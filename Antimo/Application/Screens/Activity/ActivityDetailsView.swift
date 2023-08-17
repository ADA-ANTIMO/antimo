//
//  ActivityDetailsView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 11/06/23.
//

import CoreData
import SwiftUI

struct ActivityDetailsView: View {

  // MARK: Lifecycle

  init(selectedDate: Date) {
    let startDate = Calendar.current.date(
      from: Calendar.current.dateComponents(
        [.year, .month, .day],
        from: selectedDate))!
    let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!

    let request: NSFetchRequest<Activity> = Activity.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "createdAt", ascending: false),
    ]
    request.predicate = NSPredicate(
      format: "(createdAt >= %@) AND (createdAt <= %@)",
      startDate as CVarArg, endDate as CVarArg)
    _activities = FetchRequest(fetchRequest: request)
  }

  // MARK: Internal

  @FetchRequest var activities: FetchedResults<Activity>
  @StateObject var viewModel = JournalViewModel()

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
          ForEach(activities.byDate.keys, id: \.self) { key in
            Section {
              ForEach(activities.byDate.activities[key] ?? [], id: \.self) { activity in
                let editAction = Action(id: UUID(), type: .edit) {
                  viewModel.selectedActivity = activity
                  viewModel
                    .openActivityForm(
                      selectedActivityType: ActivityTypes
                        .getByString(type: activity.type ?? ""))
                }

                let deleteAction = Action(id: UUID(), type: .delete) {
                  viewContext.delete(activity)

                  do {
                    try viewContext.save()
                  } catch {
                    let nsError = error as NSError
                    debugPrint("Unresolved error \(nsError), \(nsError.userInfo)")
                  }
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
        .environmentObject(viewModel)
    }
  }

  // MARK: Private

  @Environment(\.managedObjectContext) private var viewContext
  @EnvironmentObject private var activityNavigation: ActivityNavigationManager
}
