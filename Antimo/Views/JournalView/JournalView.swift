//
//  DashboardView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var journalNavigation: JournalNavigationManager
    @FetchRequest(sortDescriptors: []) private var activities: FetchedResults<ExerciseActivity>
    @StateObject var notificationManager = NotificationsManager()
    
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
            if activities.isEmpty {
                Spacer()
                
                Text("There are no journals\n available yet, let's make your\n journal soon")
                    .font(.placeholder)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(activities, id: \.self) { activity in
                            Section {
                                let editAction = Action(id: UUID(), type: .Edit) {
                                    journalNavigation.push(to: .addJournal)
                                }
                                
                                let deleteAction = Action(id: UUID(), type: .Delete) {
                                    viewContext.delete(activity)
                                }
                                
                                ANActivityDetails(activity: activity, actions: [editAction, deleteAction])
                            } header: {
                                HStack {
                                    let dateText = Utilities
                                        .formattedDate(from: activity.activity!.createdAt!, format: "EEEE, d MMM yyyy")
                                    
                                    Text(dateText)
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
    }
}
