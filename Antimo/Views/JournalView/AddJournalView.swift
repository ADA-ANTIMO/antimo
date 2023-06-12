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
    
    static func getByString(type: String) -> Self {
        switch type {
        case "Nutrition":
            return Self.nutrition
        case "Medication":
            return Self.medication
        case "Exercise":
            return Self.exercise
        case "Grooming":
            return Self.grooming
        default:
            return Self.other
        }
    }
}

struct ActivityIcon: View {
    let icon: ActivityIcons
    
    var body: some View {
        ZStack {
            Image(icon.rawValue)
                .resizable()
                .frame(width: 37, height: 37)
        }
        .padding(8)
        .background(
            Color.white
        )
        .cornerRadius(8)
    }
}

struct ActivityOption: View {
    let icon: ActivityIcons
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
                ActivityOption(icon: .nutrition, label: "Nutrition") {
                    vm.openActivityForm(selectedActivityType: .nutrition)
                }
                
                ActivityOption(icon: .medication, label: "Medication") {
                    vm.openActivityForm(selectedActivityType: .medication)
                }
                
                ActivityOption(icon: .exercise, label: "Exercise") {
                    vm.openActivityForm(selectedActivityType: .exercise)
                }
                
                ActivityOption(icon: .grooming, label: "Grooming") {
                    vm.openActivityForm(selectedActivityType: .grooming)
                }
                
                ActivityOption(icon: .other, label: "Other") {
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
