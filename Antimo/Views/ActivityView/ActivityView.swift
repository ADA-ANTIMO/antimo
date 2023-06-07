//
//  SummaryView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ActivityView: View {
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @StateObject var vm = ActivityViewModel()
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Calendar") {
                Text("Add Event")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.isEventSheetPresented = true }
            }
        }, children: {
            UpcomingEventView()
        })
        .sheet(isPresented: $vm.isEventSheetPresented) { AddEventSheetView(vm: vm) }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
