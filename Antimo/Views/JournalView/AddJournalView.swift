//
//  AddActivityView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

enum ActivityTypes: String {
    case nutrition = "Nutrition"
    case medication = "Medication"
    case exercise = "Exercise"
    case grooming = "Grooming"
    case other = "Other"
}

struct ActivityIcon: View {
    let icon: String
    
    var body: some View {
        ZStack {
            Image(systemName: icon)
                .font(.system(size: 29))
                .foregroundColor(Color.anPrimary)
        }
        .padding(8)
        .background(
            Color.white
        )
        .cornerRadius(8)
    }
}

struct ActivityOption: View {
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(alignment: .center, spacing: 16) {
                ActivityIcon(icon:icon)
                
                Text(label)
                    .font(.addActivity)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                Color.anPrimaryLight
            )
            .cornerRadius(8)
        }

    }
}

struct AddJournalView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @State var isSheetPresented = false
    @State var selectedActivity: ActivityTypes = .nutrition
    
    private func openActivityForm(activity:ActivityTypes) {
        selectedActivity = activity
        isSheetPresented = true
    }
    
    private func closeActivityForm() {
        isSheetPresented = false
    }
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    routerManager.goBack()
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        
                        Text("Back")
                    }
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                })
            }, title: "Add Journal")
        } children: {
            VStack {
                ActivityOption(icon:"carrot.fill", label: "Nutrition") {
                    openActivityForm(activity: .nutrition)
                }
                
                ActivityOption(icon:"cross.case.fill", label: "Medication") {
                    openActivityForm(activity: .medication)
                }
                
                ActivityOption(icon:"tennisball.fill", label: "Exercise") {
                    openActivityForm(activity: .exercise)
                }
                
                ActivityOption(icon:"comb.fill", label: "Grooming") {
                    openActivityForm(activity: .grooming)
                }
                
                ActivityOption(icon:"heart.fill", label: "Other") {
                    openActivityForm(activity: .other)
                }
            }
            .padding()
        }
        .sheet(isPresented: $isSheetPresented) {
            JournalSheetView(activityType: selectedActivity.rawValue) {
                closeActivityForm()
            }
        }
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView()
    }
}
