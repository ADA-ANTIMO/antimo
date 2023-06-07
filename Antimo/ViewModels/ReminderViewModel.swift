//
//  ReminderViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ReminderDay: Identifiable, Hashable {
    var id: Int { value }
    var value: Int       // 1 to 7 = Sun -> Sat
    var label: String   // The description of the reminder day
    var isSelected: Bool = false
}

@MainActor
class ReminderViewModel: ObservableObject {
    // MARK: Properties
    
    @Published var selectedActivityType: ActivityTypes = .nutrition
    @Published var title: String = ""
    @Published var desc: String = ""
    @Published var time: String = ""
    @Published var frequency: String = ""
    
    @Published var isReminderFormPresented: Bool = false
    @Published var isDaysSelectorPresented: Bool = false
    
    @Published var reminderDays: [ReminderDay]
    
    init() {
        let days: [ReminderDay] = [
            ReminderDay(value: 1, label: "Every Sunday"),
            ReminderDay(value: 2, label: "Every Monday"),
            ReminderDay(value: 3, label: "Every Tuesday"),
            ReminderDay(value: 4, label: "Every Wednesday"),
            ReminderDay(value: 5, label: "Every Thursday"),
            ReminderDay(value: 6, label: "Every Friday"),
            ReminderDay(value: 7, label: "Every Saturday")
        ]
        reminderDays = days
    }
    
    // MARK: Methods
    
    func toggleSelection(for day: ReminderDay) {
        if let index = reminderDays.firstIndex(where: { $0.id == day.id }) {
            reminderDays[index].isSelected.toggle()
        }
    }
    
    func selectedDays() -> [ReminderDay] {
        return reminderDays.filter { $0.isSelected }
    }
    
    func openReminderForm() {
        isReminderFormPresented = true
    }
    
    func closeReminderForm() {
        isReminderFormPresented = false
        resetForm()
    }
    
    func resetForm() {
        selectedActivityType = .nutrition
        title = ""
        desc = ""
        time = ""
        frequency = ""
        resetSelectedReminderDays()
    }
    
    func openDaysSelectorForm() {
        isDaysSelectorPresented = true
    }
    
    func closeDaysSelectorForm() {
        isDaysSelectorPresented = false
    }
    
    func resetSelectedReminderDays() {
        for index in reminderDays.indices {
            reminderDays[index].isSelected = false
        }
    }
}
