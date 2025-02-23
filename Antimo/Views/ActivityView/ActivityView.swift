//
//  SummaryView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ActivityView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "triggerDate", ascending: true)])
    private var events: FetchedResults<Event>
    
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @StateObject var vm = ActivityViewModel()
    @StateObject var notificationManager = NotificationsManager()
    @State var currentDate = Date.now
    @State var currentMonth = 0
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Event") {
                Text("Add Event")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.isEventSheetPresented = true }
            }
        }, children: {
            ScrollView {
                ANCalendar(currentDate: $currentDate, currentMonth: $currentMonth)
                UpcomingEventView(vm: vm, events: events, onShowAll: { activityNavigation.push(to: .allEvents) })
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
        .sheet(isPresented: $vm.isEventSheetPresented) {
            AddEventSheetView(
                vm: vm,
                onSubmit: {
                    vm.addEvent(viewContext: viewContext, notificationManager: notificationManager)
                }
            )
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
