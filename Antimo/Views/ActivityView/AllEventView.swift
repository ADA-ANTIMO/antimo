//
//  AllEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct AllEventView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "reminder.createdAt", ascending: false)]) private var events: FetchedResults<Event>
    
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @StateObject var vm = ActivityViewModel()
    @StateObject var notificationManager = NotificationsManager()
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(leading: {
                Text("Back")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { activityNavigation.goBack() }
            }, title: "Add Reminder") {
                Text("Add Event")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.isEventSheetPresented = true }
            }
        }, children: {
            ForEach(events) { event in
                ANEventCard(
                    icon: vm.getIcon(event.reminder?.type ?? ""),
                    title: event.reminder?.title ?? "",
                    desc: event.reminder?.desc ?? "",
                    time: vm.getRenderedHourAndMinutes(event.triggerDate ?? Date())
                )
            }
            .padding(.horizontal)
        })
        // TODO: Pass onSubmit
        .sheet(isPresented: $vm.isEventSheetPresented) { AddEventSheetView(vm: vm, onSubmit: {
            vm.addEvent(viewContext: viewContext, notificationManager: notificationManager)
        }) }
    }
}

struct AllEventView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventView()
    }
}
