//
//  ActivityAddJournalView.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 05/06/23.
//

import SwiftUI

struct ActivityAddJournalView: View {
    @EnvironmentObject private var activityNavigation: ActivityNavigationManager
    @StateObject var vm = JournalViewModel()
    
    var body: some View {
        ANBaseContainer {
            ANToolbar(leading: {
                Button(action: {
                    activityNavigation.goBack()
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
