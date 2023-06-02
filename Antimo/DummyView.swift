//
//  MenuView.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import SwiftUI

struct DummyView: View {
    
    
    var body: some View {
        TabView {
            Group {
                DashboardView()
                    .tabItem {
                        Label("Dashboard", systemImage: "house")
                    }
                
                ReminderView()
                    .tabItem {
                        Label("Reminder", systemImage: "alarm")
                    }
                
                SummaryView()
                    .tabItem {
                        Label("Summary", systemImage: "pill")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                    }
            }
        }
        .preferredColorScheme(.light)
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView()
    }
}
