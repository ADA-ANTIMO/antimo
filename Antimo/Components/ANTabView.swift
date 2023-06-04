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
                        Label {
                            Text("Dashboard")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "house")
                        }
                    }
                    .tag(0)
                
                ReminderView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Dashboard")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "house")
                        }
                    }
                    .tag(1)
                
                SummaryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Summary")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "pill")
                        }
                    }
                    .tag(2)
                ProfileView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Profile")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "person")
                        }
                    }
                    .tag(3)
            }
            .preferredColorScheme(.light)
            

    }
}
