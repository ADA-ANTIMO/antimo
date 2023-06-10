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
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "createdAt", ascending: false)]) private var activities: FetchedResults<Activity>
    @StateObject var notificationManager = NotificationsManager()
    @StateObject var vm = JournalViewModel()
    @State var dictOfActivities = [String: [Activity]]()
    @State var keyOfDict: [String] = []
    
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
                        ForEach(keyOfDict, id: \.self) { key in
                            Section {
                                ForEach(dictOfActivities[key] ?? [], id: \.self) { activity in
                                    let editAction = Action(id: UUID(), type: .Edit) {
                                        vm.selectedActivity = activity
                                        vm.openActivityForm(selectedActivityType: ActivityTypes.getByString(type: activity.type ?? ""))
                                    }
                                    
                                    let deleteAction = Action(id: UUID(), type: .Delete) {
                                        viewContext.delete(activity)
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
        .onAppear {
            for activity in activities {
                 let key = Utilities.formattedDate(from: activity.createdAt!, format: "EEEE, d MMM yyyy")
                
                if var dict = dictOfActivities[key] {
                    dict.append(activity)
                    
                    dictOfActivities[key] = dict
                } else {
                    keyOfDict.append(key)
                    dictOfActivities[key] = [activity]
                }
            }
        }
        .onDisappear {
            dictOfActivities = [String: [Activity]]()
            keyOfDict = []
        }
    }
}
