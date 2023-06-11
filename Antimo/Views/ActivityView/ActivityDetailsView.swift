//
//  ActivityDetailsView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 11/06/23.
//

import SwiftUI

struct ActivityDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @FetchRequest(sortDescriptors: []) private var activities: FetchedResults<Activity>
    @StateObject var vm = JournalViewModel()
    
    let selectedDate:Date
   
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
        })
        .sheet(isPresented: $vm.isSheetPresented, onDismiss: {
            vm.resetState()
        }) {
            JournalSheetView()
                .environmentObject(vm)
        }
    }
}
