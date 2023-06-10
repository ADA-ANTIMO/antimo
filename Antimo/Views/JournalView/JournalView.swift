//
//  DashboardView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct JournalView: View {
    @EnvironmentObject private var journalNavigation: JournalNavigationManager
    @StateObject var notificationManager = NotificationsManager()
    @State var activities:[DummyData] = [DummyData(), DummyData()]
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Journal") {
                Button {
                    journalNavigation.push(to: .addJournal)
                } label: {
                    Text("Add Journal")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                }
            }
        }, children: {
            if activities.isEmpty {
                Spacer()
                
                Text("There are no journals\n available yet, let's make your\n journal soon")
                    .font(.placeholder)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.gray)
                
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(activities, id: \.self) { activity in
                            Section {
                                ANActivityDetails(activity: activity)
                            } header: {
                                HStack {
                                    Text("Monday, 29 May 2023")
                                        .font(.date)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
                .frame(maxWidth: .infinity)
            }
        })
    }
}
