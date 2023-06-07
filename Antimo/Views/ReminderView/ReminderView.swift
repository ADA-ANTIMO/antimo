//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ReminderView: View {
    @StateObject var vm = ReminderViewModel()
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Reminder") {
                Text("Add Reminder")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture { vm.openReminderForm() }
            }
        }, children: {
            ScrollView {
                ANReminderCard(icon: .nutrition, title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: .exercise, title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: .grooming, title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: .other, title: "Meal Time", time: "10.00", frequency: "Every Day")
            }
            .padding(.horizontal)
        })
        .sheet(isPresented: $vm.isReminderFormPresented) { ReminderFormView(vm: vm) }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
