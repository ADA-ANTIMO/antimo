//
//  DashboardView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct AddExerciseView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        Group {
            Text("Add Exercise Form")
            
            Button("Back to dashboard") {
                routerManager.reset()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct AddNutritionView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        Group {
            Text("Add Nutrition Form")
            
            Button("Back to dashboard") {
                routerManager.reset()
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct DashboardListAcitivityView: View {
    @State var isFormVisible: Bool = false
    
    var body: some View {
        Group {
            NavigationLink(value: Route.addExercise) {
                Text("Add Exercise")
            }
            
            NavigationLink(value: Route.addNutrition) {
                Text("Add Nutrition")
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

struct DashboardView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @StateObject var notificationManager = NotificationsManager()
    
    @State var activities = [DummyData(), DummyData(), DummyData()]
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            VStack(spacing: 0) {
                ANToolbar(title: "Journal") {
                    NavigationLink(value: Route.addActivities) {
                        Text("Add Activity")
                            .font(.toolbar)
                            .foregroundColor(Color.anNavigation)
                    }
                    .navigationDestination(for: Route.self) {
                        $0
                    }
                }
                
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
            }
        }
    }
}
