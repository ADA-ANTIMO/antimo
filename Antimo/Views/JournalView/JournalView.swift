//
//  DashboardView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import CoreData

struct JournalView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var journalNavigation: JournalNavigationManager
    @FetchRequest var activities: FetchedResults<Activity>
    @StateObject var vm = JournalViewModel()
    
    init () {
        let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now) ?? Date.now
        let startDate = Calendar.current.startOfDay(for: lastWeek)
        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: Date.now) ?? Date.now
        
        let request: NSFetchRequest<Activity> = Activity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: false)
        ]
        request.predicate = NSPredicate(format: "(createdAt >= %@) AND (createdAt <= %@)", startDate as CVarArg, endDate as CVarArg)

        _activities = FetchRequest(fetchRequest: request)
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
                        ForEach(activities.byDate.keys, id: \.self) { key in
                            Section {
                                ForEach(activities.byDate.activities[key] ?? [], id: \.self) { activity in
                                    let editAction = Action(id: UUID(), type: .Edit) {
                                        vm.selectedActivity = activity
                                        vm.openActivityForm(selectedActivityType: ActivityTypes.getByString(type: activity.type ?? ""))
                                    }
                                    
                                    let deleteAction = Action(id: UUID(), type: .Delete) {
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
            }
        })
        .sheet(isPresented: $vm.isSheetPresented, onDismiss: {
            vm.resetState()
        }) {
            JournalSheetView()
                .environmentObject(vm)
        }
    }
}
