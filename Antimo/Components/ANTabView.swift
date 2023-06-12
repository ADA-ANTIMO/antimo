//
//  ANTabView.swift
//  Antimo
//
//  Created by Roli Bernanda on 30/05/23.
//

import SwiftUI

enum NavigationTabs: String {
    case summary = "Summary"
    case journal = "Journal"
    case activity = "Activity"
    case reminder = "Reminder"
}

struct ANTabView: View {
    @Binding var selectedTab: NavigationTabs
    
    @StateObject var journalNavigation = JournalNavigationManager()
    @StateObject var activityNavigation = ActivityNavigationManager()
    @StateObject var dashboardNavigation = DashboardNavigationManager()
    
    // TODO: Change TabBar Icons
    var body: some View {
            TabView(selection: $selectedTab) {
                NavigationStack(path: $dashboardNavigation.dashboardPaths) {
                    SummaryView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationDestination(for: DashboardRoute.self) { route in
                            switch(route) {
                            case .allEvents:
                                DashboardAllEventView()
                            }
                        }
                }
                
                .tabItem {
                    Label {
                        Text("Summary")
                            .font(.tab)
                    } icon: {
                        Image(systemName: "chart.bar.xaxis")
                    }
                }
                .tag(NavigationTabs.summary)
                .environmentObject(dashboardNavigation)
                
                NavigationStack(path: $journalNavigation.journalPaths) {
                    JournalView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationDestination(for: JournalRoute.self) { route in
                            switch(route) {
                            case .addJournal:
                                AddJournalView()
                            }
                        }
                }
                .tabItem {
                    Label {
                        Text("Journal")
                            .font(.tab)
                    } icon: {
                        Image(systemName: "text.book.closed.fill")
                    }
                }
                .tag(NavigationTabs.journal)
                .environmentObject(journalNavigation)
                    
                
                NavigationStack(path: $activityNavigation.activityPaths) {
                    ActivityView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .navigationDestination(for: ActivityRoute.self) { route in
                            switch(route) {
                            case .allEvents:
                                AllEventView()
                            case let .activitesPerDate(selectedDate):
                                ActivityDetailsView(selectedDate: selectedDate)
                            case .addJournal:
                                ActivityAddJournalView()
                            }
                        }
                }
                .tabItem {
                    Label {
                        Text("Activity")
                            .font(.tab)
                    } icon: {
                        Image(systemName: "calendar")
                    }
                }
                .tag(NavigationTabs.activity)
                .environmentObject(activityNavigation)
                
                ReminderView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Reminder")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "alarm.fill")
                        }
                    }
                    .tag(NavigationTabs.reminder)
                
            }
            .tint(Color.anPrimary)
            .preferredColorScheme(.light)
    }
}
