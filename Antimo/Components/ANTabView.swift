//
//  ANTabView.swift
//  Antimo
//
//  Created by Roli Bernanda on 30/05/23.
//

import SwiftUI

struct ANTabView: View {
    @Binding var selectedTab: Int
    
    // TODO: Change TabBar Icons
    var body: some View {
            TabView(selection: $selectedTab) {
                DashboardView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label("Dashboard", systemImage: "house")
                    }
                    .tag(0)
                
                ReminderView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label("Reminder", systemImage: "alarm")
                    }
                    .tag(1)
                
                SummaryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label("Summary", systemImage: "pill")
                            .background(Color.blue)
                    }
                    .tag(2)
                ProfileView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label("Profile", systemImage: "person")
                            .background(Color.blue)
                    }
                    .tag(3)
            }
            .preferredColorScheme(.light)

    }
}

struct ANTabView_Previews: PreviewProvider {
    static var previews: some View {
        ANTabView(selectedTab: .constant(0))
    }
}
