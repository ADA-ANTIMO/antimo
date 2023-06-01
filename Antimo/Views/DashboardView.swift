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
        Text("Add Exercise Form")
        
        Button("Back to dashboard") {
            routerManager.reset()
        }
    }
}

struct AddNutritionView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        Text("Add Nutrition Form")
        
        Button("Back to dashboard") {
            routerManager.reset()
        }
    }
}

struct DashboardListAcitivityView: View {
    var body: some View {
        NavigationLink(value: Route.addExercise) {
            Text("Add Exercise")
        }
        
        NavigationLink(value: Route.addNutrition) {
            Text("Add Nutrition")
        }
    }
}

struct DashboardView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            List {
                NavigationLink(value: Route.addActivities) {
                    Text("Go to list add activity")
                }
            }
            .navigationTitle("Dashboard")
            .navigationDestination(for: Route.self) { $0 }
        }
        
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
