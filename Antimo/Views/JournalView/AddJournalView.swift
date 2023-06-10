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
    
    static func getByString(type: String) -> ActivityTypes {
        print(type, "<<<<<<< TYPE")
        
        switch type {
        case "Nutrition":
            return ActivityTypes.nutrition
        case "Medication":
            return ActivityTypes.medication
        case "Exercise":
            return ActivityTypes.exercise
        case "Grooming":
            return ActivityTypes.grooming
        default:
            return ActivityTypes.other
        }
    }
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
    @EnvironmentObject private var journalNavigation: JournalNavigationManager
    @StateObject var vm = JournalViewModel()
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    journalNavigation.goBack()
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
                    vm.openActivityForm(selectedActivityType: .nutrition)
                }
                
                ActivityOption(icon:"cross.case.fill", label: "Medication") {
                    vm.openActivityForm(selectedActivityType: .medication)
                }
                
                ActivityOption(icon:"tennisball.fill", label: "Exercise") {
                    vm.openActivityForm(selectedActivityType: .exercise)
                }
                
                ActivityOption(icon:"comb.fill", label: "Grooming") {
                    vm.openActivityForm(selectedActivityType: .grooming)
                }
                
                ActivityOption(icon:"heart.fill", label: "Other") {
                    vm.openActivityForm(selectedActivityType: .other)
                }
            }
            .padding()
        }
        .sheet(isPresented: $vm.isSheetPresented, onDismiss: {
            vm.resetState()
        }) {
            JournalSheetView()
            .environmentObject(vm)
        }
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView()
    }
}
