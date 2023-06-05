//
//  ReminderView.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

struct ReminderView: View {
    var body: some View {
        ANBaseContainer(toolbar: {
            ANToolbar(title: "Reminder") {
                NavigationLink(value: Route.addActivities) {
                    Text("Add Reminder")
                        .font(.toolbar)
                        .foregroundColor(Color.anNavigation)
                }
                .navigationDestination(for: Route.self) {
                    $0
                }
            }
        }, children: {
            ScrollView {
                Text("CHILDREN")
                    .frame(height: 400)
                    .background(.yellow)
                Text("CHILDREN")
                    .frame(height: 400)
                    .background(.yellow)
                Text("CHILDREN")
                    .frame(height: 400)
                    .background(.yellow)
                Text("CHILDREN")
                    .frame(height: 400)
                    .background(.yellow)
                Text("CHILDREN")
                    .frame(height: 400)
                    .background(.yellow)
            }
            .padding(.horizontal)
        })
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
