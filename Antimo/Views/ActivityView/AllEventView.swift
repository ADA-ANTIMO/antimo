//
//  AllEventView.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI

struct AllEventView: View {
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @StateObject var vm = ActivityViewModel()
    
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
            ScrollView {
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
                ANEventCard(icon: .nutrition, title: "Bring To Central Park", desc: "Central park is a good place to bring Milo. We can meet others dog owner ...", time: "10:00")
            }
        })
        .sheet(isPresented: $vm.isEventSheetPresented) { AddEventSheetView(vm: vm) }
    }
}

struct AllEventView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventView()
    }
}
