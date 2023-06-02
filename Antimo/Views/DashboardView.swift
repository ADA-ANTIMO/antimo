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
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            ScrollView {
                NavigationLink(value: Route.addActivities) {
                    Text("Go to list add activity")
                }
                .navigationDestination(for: Route.self) { $0 }
                
                Group {
                    Button("Schedule notification") {
                        notificationManager.scheduleEventNotification()
                    }
                    .padding(.all)
                    .background(Color("PrimaryColor"))
                    .foregroundColor(.white)
                    
                }
                .frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
