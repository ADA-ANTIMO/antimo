//
//  MenuView.swift
//  Antimo
//
//  Created by Roli Bernanda on 01/06/23.
//

import SwiftUI

struct DummyView: View {
    @StateObject var routerManager = NavigationRouter()
    
    var body: some View {
        TabView {
            DashboardView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabItem {
                    Label("Dashboard", systemImage: "house")
                }
                .environmentObject(routerManager)
            
            ReminderView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabItem {
                    Label("Reminder", systemImage: "alarm")
                }
                .environmentObject(routerManager)
            
            SummaryView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabItem {
                    Label("Summary", systemImage: "pill")
                        .background(Color.blue)
                }
                .environmentObject(routerManager)
            ProfileView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabItem {
                    Label("Profile", systemImage: "person")
                        .background(Color.blue)
                }
                .environmentObject(routerManager)
        }
        .preferredColorScheme(.light)
    }
}

struct DummyView_Previews: PreviewProvider {
    static var previews: some View {
        DummyView()
    }
}
