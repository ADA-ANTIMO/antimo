//
//  ActivityDetailsView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 11/06/23.
//

import SwiftUI
import CoreData

struct ActivityDetailsView: View {
    var selectedDate: Date
    
    var startDate: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: selectedDate))!
    }
    
    var endDate: Date {
        Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: startDate)!
    }
    
    @EnvironmentObject private var vm: JournalViewModel
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
   
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
                    ForEach(vm.activitiesByDate.keys, id: \.self) { key in
                        Section {
                            ForEach(vm.activitiesByDate.activities[key] ?? [], id: \.id) { activity in
                                let editAction = Action(type: .edit) {
                                    vm.setState(activity: activity)
                                    vm.openActivityForm(selectedActivityType: activity.activityType)
                                }
                                
                                let deleteAction = Action(type: .delete) {
                                    vm.deleteActivityById(id: activity.id)
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
