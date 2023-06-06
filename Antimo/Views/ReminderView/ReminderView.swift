//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

let days = ["Every Sunday", "Every Monday", "Every Tuesday", "Every Wednesday", "Every Thursday", "Every Friday", "Every Saturday"]

struct ReminderView: View {
    @State var reminderType: String = ""
    @State var title: String = ""
    @State var desc: String = ""
    @State var time: String = ""
    @State var frequency: String = ""
    
    @State var isSheetPresented: Bool = false
    @State var isDaysSelectorPresented: Bool = false
    @State var daysSelection = Set<String>()
    
    private func openReminderForm() {
        isSheetPresented = true
    }
    
    private func closeReminderForm() {
        isSheetPresented = false
        resetForm()
    }
    
    private func resetForm() {
        reminderType = ""
        title = ""
        desc = ""
        time = ""
        frequency = ""
        daysSelection.removeAll()
    }
    
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Reminder") {
                Text("Add Reminder")
                    .font(.toolbar)
                    .foregroundColor(Color.anNavigation)
                    .onTapGesture {
                        openReminderForm()
                    }
            }
        }, children: {
            ScrollView {
                ANReminderCard(icon: "doc", title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: "doc", title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: "doc", title: "Meal Time", time: "10.00", frequency: "Every Day")
                ANReminderCard(icon: "doc", title: "Meal Time", time: "10.00", frequency: "Every Day")
            }
            .padding()
        })
        .sheet(isPresented: $isSheetPresented) {
            VStack {
                ANToolbar(leading: {
                    Text("Cancel")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture {
                            closeReminderForm()
                        }
                }, title: "Add Reminder") {
                    Text("Save")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                        .onTapGesture {
                            closeReminderForm()
                        }
                }
                
                VStack {
                    ANActivitySelector()
                    ANTextField(text: .constant(""), placeholder: "Add reminder title...", label: "Title")
                    
                    ANTextFieldArea(text: .constant(""), label: "Description", placeholder: "Add description...")
                        .frame(height: 200)
                    
                    ANTimePicker(time: .constant(Date()), label: "Time")
                    
                    HStack {
                        Text("Repeat")
                        Spacer()
                        Text("Weekday")
                            .onTapGesture {
                                isSheetPresented = false
                                isDaysSelectorPresented = true
                            }
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding(.vertical)
        }
        .sheet(isPresented: $isDaysSelectorPresented) {
            VStack {
                ANToolbar(leading: {
                    Text("Back").font(.toolbar).foregroundColor(.anNavigation).onTapGesture {
                        openReminderForm()
                            isDaysSelectorPresented = false
                        }
                }, title: "Repeat")
            }
            .padding(.vertical)
            
            List(days, id: \.self, selection: $daysSelection) { day in
                Text(day)
                    .onTapGesture {
                        if daysSelection.contains(day) {
                            daysSelection.remove(day)
                        } else {
                            daysSelection.insert(day)
                        }
                    }
            }
            Spacer()
            
        }
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
