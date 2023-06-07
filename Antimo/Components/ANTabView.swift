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
    
    // TODO: Change TabBar Icons
    var body: some View {
            TabView(selection: $selectedTab) {
                SummaryView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Summary")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "chart.bar.xaxis")
                        }
                    }
                    .tag(NavigationTabs.summary)
                
                JournalView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Journal")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "text.book.closed.fill")
                        }
                    }
                    .tag(NavigationTabs.journal)
                
                ActivityView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tabItem {
                        Label {
                            Text("Activity")
                                .font(.tab)
                        } icon: {
                            Image(systemName: "calendar")
                        }
                    }
                    .tag(NavigationTabs.activity)
                
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
            .preferredColorScheme(.light)
    }
}
