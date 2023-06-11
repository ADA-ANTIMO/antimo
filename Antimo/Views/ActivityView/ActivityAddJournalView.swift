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
